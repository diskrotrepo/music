import os
import sqlite3
import numpy as np
import torch
import pickle

from infer import (
    get_style_prompt,
    prepare_model,
)

assert torch.cuda.is_available(), "only available on gpu"

device = "cuda"

cfm, tokenizer, muq, vae = prepare_model(device)


# Database setup
db_path = "embeddings.db"
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Create table if not exists
cursor.execute(
    """
    CREATE TABLE IF NOT EXISTS embeddings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        filename TEXT,
        tag TEXT,
        vector_embedding BLOB
    )
"""
)
conn.commit()

# Folder containing MP3 files
mp3_folder = "./dataset/mp3s"

# Process each file in the folder
for filename in os.listdir(mp3_folder):
    if filename.endswith(".mp3"):
        mp3file = os.path.join("dataset", "mp3s", filename)
        print("Processing " + mp3file)

        style_prompt = get_style_prompt(muq, mp3file)
        vector = pickle.dumps(style_prompt)
        tags = filename.replace(".mp3", "").split("_")

        for tag in tags:

            cursor.execute(
                """
                INSERT INTO embeddings (filename, tag, vector_embedding)
                VALUES (?, ?, ?)
            """,
                (filename, tag, vector),
            )

# Commit changes and close connection
conn.commit()
conn.close()

print("Embedding process completed.")
