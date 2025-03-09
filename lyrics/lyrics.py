import os
from openai import OpenAI

client = OpenAI(
    api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
)


def calculate_lrc(lyrics):
    chat_completion = client.chat.completions.create(
        messages=[
            {
                "role": "system",
                "content": "You are a helpful assistant that calculates the lrc time for the lyrics. Return only the lrc file without comment.",
            },
            {
                "role": "user",
                "content": lyrics,
            },
        ],
        model="gpt-4o",
    )

    return chat_completion.choices[0].message.content
