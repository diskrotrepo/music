import os
import sqlite3
import numpy as np
import torch
import pickle

from infer import (
    get_style_prompt,
    prepare_model,
)

# Ensure CUDA is available
assert torch.cuda.is_available(), "only available on GPU"

device = "cuda"

# Load model components
cfm, tokenizer, muq, vae = prepare_model(device)

# Folder containing MP3 files
mp3_folder = "./dataset/mp3s"
files = [f for f in os.listdir(mp3_folder) if f.endswith(".mp3")]
total_files = len(files)

# Database setup
db_path = "embeddings.db"

# Open and close connection for each transaction to avoid locking issues
with sqlite3.connect(db_path) as conn:
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

    # Create index for faster queries
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_tag ON embeddings (tag);")

    conn.commit()  # Commit table creation before inserting data

i = 0

# Process each file in the folder
for filename in files:
    mp3file = os.path.join(mp3_folder, filename)
    print(f"Processing {filename} ({i+1} of {total_files})")
    i += 1

    style_prompt = get_style_prompt(muq, mp3file)

    if isinstance(style_prompt, torch.Tensor):
        style_prompt = style_prompt.cpu().numpy()  # Convert CUDA tensor to NumPy

    vector = pickle.dumps(style_prompt)
    tags = filename.replace(".mp3", "").split("_")

    # Insert data into the database in a separate connection
    with sqlite3.connect(db_path) as conn:
        cursor = conn.cursor()
        for tag in tags:
            print(f"{filename} with {tag}")
            cursor.execute(
                """
                INSERT INTO embeddings (filename, tag, vector_embedding)
                VALUES (?, ?, ?)
                """,
                (filename, tag, vector),
            )
        conn.commit()  # Commit after inserting each file

print("Embedding process completed.")
