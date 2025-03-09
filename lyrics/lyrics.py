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


def calculate_lrc(lyrics):

    with open("./config/lyricPrompt.txt", "r") as f:
        systemPrompt = f.read()

    chat_completion = client.chat.completions.create(
        messages=[
            {
                "role": "system",
                "content": systemPrompt,
            },
            {
                "role": "user",
                "content": lyrics,
            },
        ],
        model=os.environ.get("MODEL"),
    )

    lrc = chat_completion.choices[0].message.content
    print(lrc)
    return lrc
