import os
from openai import OpenAI

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


def calculate_lrc(lyrics, prompt):

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
    return lrc
