import os

def get_default_lrc_prompt():
    """Reads the lyric prompt from music_backend/config/lrcDefault.txt."""
    prompt_path = os.path.join("music_backend", "config", "lrcDefault.txt")

    try:
        with open(prompt_path, "r", encoding="utf-8") as file:
            return file.read().strip()
    except FileNotFoundError:
        print(f"Error: Missing {prompt_path}")
        return None
    except Exception as e:
        print(f"Error reading {prompt_path}: {e}")
        return None     