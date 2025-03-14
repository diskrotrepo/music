import os
from openai import OpenAI


def calculate_lrc(lyrics, prompt):

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
    print(lrc)
    return lrc


def get_default_lrc_prompt():
    """Reads the lyric prompt from music_shared/config/lrcDefault.txt."""
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.abspath(os.path.join(script_dir, ".."))
    prompt_path = os.path.join(project_root, "music_shared", "config", "lrcDefault.txt")

    try:
        with open(prompt_path, "r", encoding="utf-8") as file:
            return file.read().strip()
    except FileNotFoundError:
        print(f"Error: Missing {prompt_path}")
        return None
    except Exception as e:
        print(f"Error reading {prompt_path}: {e}")
        return None
