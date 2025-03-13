
import os
from music_queue.extensions import db
from openai import OpenAI
from music_queue.extensions import lrc_pipeline
from music_shared.models import Prompt, PromptyCategoryEnum
from diffrhythm.infer import generate
from music_shared.lrc import get_default_lrc_prompt

def lrc_pipeline_results(lyrics, lrcPrompt):

    if lrc_pipeline is None:
        raise ValueError("LRC Pipeline is not initialized! Make sure `register_pipelines()` was called.")

    messages = [{"role": "system", "content": lrcPrompt}]
    messages.append({"role": "user", "content": lyrics})
    prompt = lrc_pipeline.tokenizer.apply_chat_template(
        messages,
        tokenize=False,
        add_generation_prompt=True
    )

    terminators = [
        lrc_pipeline.tokenizer.eos_token_id,
        lrc_pipeline.tokenizer.convert_tokens_to_ids("<|eot_id|>")
    ]

    outputs = lrc_pipeline(
        prompt,
        max_new_tokens=len(lyrics) + 100,
        eos_token_id=terminators,
        do_sample=True,
        temperature=0.6,
        top_p=0.9,
    )

    return outputs[0]['generated_text'][len(prompt):].strip()

def calculate_lrc(lyrics, prompt):

    llm_source = os.environ.get("LLM_SOURCE")
    if llm_source not in {"huggingface", "local", "openai"}:
        raise ValueError("LLM_SOURCE must be one of: 'huggingface', 'local', or 'openai'")

    if  llm_source == "huggingface":    
        return lrc_pipeline_results(lyrics, prompt)
        
    if os.environ.get("LLM_SOURCE") == "local":
        print("Using local LLM")
        client = OpenAI(
            base_url=os.environ.get("LLM_API"),
            api_key=os.environ.get("OPENAI_API_KEY"),
        )
    else:
        print("Using OpenAI")
        client = OpenAI(
            api_key=os.environ.get("OPENAI_API_KEY"),
        )
    
    try: 
        chat_completion = client.chat.completions.create(
            messages=[
                {
                    "role": "system",
                    "content": prompt.prompt,
                },
                {
                    "role": "user",
                    "content": lyrics,
                },
            ],
            model=prompt.model,
        )

        lrc = chat_completion.choices[0].message.content
        print(lrc)
    except Exception as e:
        return lyrics

    return lrc  


def dur():
    
    lrcPrompt = (
        db.session.query(Prompt)
        .filter_by(category=PromptyCategoryEnum.LRC, is_default=True)
        .first()
    )

    if not lrcPrompt:
        lrcPrompt = get_default_lrc_prompt()

    generation_id = generate(
        lyrics=data.get("lyrics", ""),
        lrcPrompt=lrcPrompt,
        input_file=data.get("input"),
        audio_length=data.get("duration"),
        steps=data.get("steps"),
        cfg_strength=data.get("cfg_strength"),
        chunked=data.get("chunked"),
        tags=data.get("tags"),
        negative_tags=data.get("negative_tags"),
        use_embeddings=data.get("use_embedding", False),
    )