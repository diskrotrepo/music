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
import argparse
import os
import time
from lyrics import calculate_lrc

import os
print("Current working directory:", os.getcwd())

from infer_utils import (
    get_reference_latent,
    get_lrc_token,
    get_style_prompt,
    prepare_model,
    get_negative_style_prompt,
    decode_audio
)

def inference(cfm_model, vae_model, cond, text, duration, style_prompt, negative_style_prompt, start_time, steps, cfg_strength):   
    with torch.inference_mode():
        generated, _ = cfm_model.sample(
            cond=cond,
            text=text,
            duration=duration,
            style_prompt=style_prompt,
            negative_style_prompt=negative_style_prompt,
            steps=steps,
            cfg_strength=cfg_strength,
            start_time=start_time
        )
        
        generated = generated.to(torch.float32)
        latent = generated.transpose(1, 2) # [b d t]
    
        output = decode_audio(latent, vae_model, chunked=False)

        # Rearrange audio batch to a single sequence
        output = rearrange(output, "b d n -> d (b n)")
        # Peak normalize, clip, convert to int16, and save to file
        output = output.to(torch.float32).div(torch.max(torch.abs(output))).clamp(-1, 1).mul(32767).to(torch.int16).cpu()
        
        return output
        
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--lyrics', type=str, default="infer/example/eg.lrc", help="lyrics of target song") # lyrics of target song
    parser.add_argument('--input_file', type=str, default="eg.mp3", help="reference audio as style prompt for target song") # reference audio as style prompt for target song
    parser.add_argument('--audio-length', type=int, default=95, choices=[95], help="length of generated song") # length of target song
    parser.add_argument('--repo_id', type=str, default="ASLP-lab/DiffRhythm-base", help="target model")
    parser.add_argument('--output-file', type=str, default="output.wav", help="output filename for generated song") # output directory fo target song
    parser.add_argument('--steps', type=int, default=32, help="steps")
    parser.add_argument('--cfg_strength', type=float, default=6.0, help="cfg strength")

    args = parser.parse_args()

    # vlrc-path
    
    assert torch.cuda.is_available(), "only available on gpu"

    device = 'cuda'
    
    audio_length = args.audio_length
    if audio_length == 95:
        max_frames = 2048
    elif audio_length == 285: # current not available
        max_frames = 6144
    
    cfm, tokenizer, muq, vae = prepare_model(device)
    
    
    lrc = calculate_lrc(args.lyrics)

    print(lrc)

    lrc_prompt, start_time = get_lrc_token(lrc, tokenizer, device)
    
    input_path = os.path.join("input", args.input_file)


    style_prompt = get_style_prompt(muq, input_path)
    
    negative_style_prompt = get_negative_style_prompt(device)
    
    latent_prompt = get_reference_latent(device, max_frames)

    print(style_prompt)
    print(negative_style_prompt)
    print(latent_prompt)
    
    s_t = time.time()
    generated_song = inference(
        cfm_model=cfm, 
        vae_model=vae, 
        cond=latent_prompt, 
        text=lrc_prompt, 
        duration=max_frames, 
        style_prompt=style_prompt,
        negative_style_prompt=negative_style_prompt,
        start_time=start_time,
        steps=args.steps,
        cfg_strength=args.cfg_strength
    )
    e_t = time.time() - s_t
    print(f"inference cost {e_t} seconds")
    
    output_file = args.output_file
  
    
    output_path = os.path.join("output", output_file)

    print (output_path)

    torchaudio.save(output_path, generated_song, sample_rate=44100)
    