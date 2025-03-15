# Copyright (c) 2025 ASLP-LAB
#               2025 Huakang Chen  (huakang@mail.nwpu.edu.cn)
#               2025 Guobin Ma     (guobin.ma@gmail.com)
#
# Licensed under the Stability AI License (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   https://huggingface.co/stabilityai/stable-audio-open-1.0/blob/main/LICENSE.md
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import torch
import torchaudio
from einops import rearrange
import os
import time
import uuid
import logging
from music_inferencing.lyrics import calculate_lrc

from music_shared.models import Prompt

import os

PROJECT_ROOT_DIR = (
    os.path.abspath(os.path.dirname(__file__))
    .replace("diffrhythm", "")
    .replace("infer", "")
)


from diffrhythm.infer.infer_utils import (
    get_reference_latent,
    get_lrc_token,
    get_style_prompt,
    prepare_model,
    get_negative_style_prompt,
    decode_audio,
)


def inference(
    cfm_model,
    vae_model,
    cond,
    text,
    duration,
    style_prompt,
    negative_style_prompt,
    start_time,
    steps,
    cfg_strength,
    chunked=False,
):
    with torch.inference_mode():
        generated, _ = cfm_model.sample(
            cond=cond,
            text=text,
            duration=duration,
            style_prompt=style_prompt,
            negative_style_prompt=negative_style_prompt,
            steps=steps,
            cfg_strength=cfg_strength,
            start_time=start_time,
        )

        generated = generated.to(torch.float32)
        latent = generated.transpose(1, 2)  # [b d t]

        output = decode_audio(latent, vae_model, chunked=chunked)

        # Rearrange audio batch to a single sequence
        output = rearrange(output, "b d n -> d (b n)")
        # Peak normalize, clip, convert to int16, and save to file
        output = (
            output.to(torch.float32)
            .div(torch.max(torch.abs(output)))
            .clamp(-1, 1)
            .mul(32767)
            .to(torch.int16)
            .cpu()
        )

        return output


def generate(
    lyrics,
    input_file,
    audio_length,
    steps,
    cfg_strength,
    chunked,
    tags,
    lrcPrompt=Prompt,
    negative_tags=None,
    use_embeddings=False,
):

    assert tags or input_file, "either tags or input should be provided"
    assert not (tags and input_file), "only one of them should be provided"

    device = "cpu"

    if torch.cuda.is_available():
        device = "cuda"
    elif torch.mps.is_available():
        device = "mps"

    assert device != "cpu", "CPU is not supported for inference. Please use GPU or MPS."

    if audio_length == 95:
        max_frames = 2048
    elif audio_length == 285:  # current not available
        max_frames = 6144
    else:
        raise ValueError(f"Unsupported audio_length: {audio_length}")

    cfm, tokenizer, muq, vae = prepare_model(device)

    if lyrics != "":
        lrc = calculate_lrc(lyrics, lrcPrompt)
    else:
        lrc = ""

    lrc_prompt, start_time = get_lrc_token(lrc, tokenizer, device)

    if input_file:
        input_path = os.path.join("input", input_file)
        style_prompt = get_style_prompt(muq, input_path)
    else:
        style_prompt = get_style_prompt(muq, prompt=tags)

    if negative_tags:
        negative_style_prompt = get_style_prompt(muq, prompt=negative_tags)
    else:
        negative_style_prompt = get_negative_style_prompt(device)

    latent_prompt = get_reference_latent(device, max_frames)

    s_t = time.time()
    logging.info(f"start inference with {tags}")
    generated_song = inference(
        cfm_model=cfm,
        vae_model=vae,
        cond=latent_prompt,
        text=lrc_prompt,
        duration=max_frames,
        style_prompt=style_prompt,
        negative_style_prompt=negative_style_prompt,
        start_time=start_time,
        steps=steps,
        cfg_strength=cfg_strength,
        chunked=chunked,
    )
    e_t = time.time() - s_t
    logging.info(f"inference cost {e_t} seconds")

    id = str(uuid.uuid4())

    output_path = os.path.join(PROJECT_ROOT_DIR, "music_output", "{}.wav".format(id))
    logging.info(f"Writing file to {output_path}")

    torchaudio.save(output_path, generated_song, sample_rate=44100)
    return output_path
