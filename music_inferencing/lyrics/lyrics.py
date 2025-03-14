import os
from openai import OpenAI
from music_inferencing.extensions import poet_pipeline, lrc_pipeline
import logging


def get_pipeline_results(lyrics, lyricPrompt, pipeline):

    if pipeline is None:
        raise ValueError(
            "Pipeline is not initialized! Make sure `register_pipelines()` was called."
        )

    messages = [{"role": "system", "content": lyricPrompt.prompt}]
    messages.append({"role": "user", "content": lyrics})

    logging.info(messages)

    prompt = pipeline.tokenizer.apply_chat_template(
        messages, tokenize=False, add_generation_prompt=True
    )

    terminators = [
        pipeline.tokenizer.eos_token_id,
        pipeline.tokenizer.convert_tokens_to_ids("<|eot_id|>"),
    ]

    outputs = pipeline(
        prompt,
        max_new_tokens=len(lyrics) + 100,
        eos_token_id=terminators,
        do_sample=True,
        temperature=0.6,
        top_p=0.9,
    )

    results = outputs[0]["generated_text"][len(prompt) :].strip()
    logging.info(results)
    return results


def write_lyrics(lyrics, prompt):

    llm_source = os.environ.get("LLM_SOURCE")
    if llm_source not in {"huggingface", "local", "openai"}:
        raise ValueError(
            "LLM_SOURCE must be one of: 'huggingface', 'local', or 'openai'"
        )

    if llm_source == "huggingface":
        return get_pipeline_results(lyrics, prompt, poet_pipeline)

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

        poetLyrics = chat_completion.choices[0].message.content
        logging.info(poetLyrics)
    except Exception as e:
        return lyrics

    return poetLyrics


def calculate_lrc(lyrics, prompt):

    llm_source = os.environ.get("LLM_SOURCE")
    if llm_source not in {"huggingface", "local", "openai"}:
        raise ValueError(
            "LLM_SOURCE must be one of: 'huggingface', 'local', or 'openai'"
        )

    if llm_source == "huggingface":
        return get_pipeline_results(lyrics, prompt, lrc_pipeline)

    if os.environ.get("USE_LOCAL_LLM"):
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
    return lrc
