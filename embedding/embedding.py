import sqlite3
import pickle
import numpy as np
import torch

# Database path
db_path = "embeddings.db"


def get_embeddings(tags):
    """Fetch embeddings for a list of tags."""
    embeddings = []
    weights = []
    tags = tags.split(",")

    for i, tag in enumerate(tags):
        embedding = find_tag_vector(tag)
        if embedding is not None:
            weight = 1.0 - (
                i * 0.1
            )  # Reduce weight by 0.1 per tag (e.g., 1.0, 0.9, 0.8...)
            if weight <= 0:  # Prevent weight from going negative
                break
            embeddings.append(embedding * weight)
            weights.append(weight)

    if not embeddings:
        return None  # No embeddings found

    # Compute weighted sum and normalize
    merged_embedding = np.sum(embeddings, axis=0) / sum(weights)
    return merged_embedding


def find_tag_vector(search_tag):
    vector = None

    # Connect to the database and fetch a random row
    with sqlite3.connect(db_path) as conn:
        cursor = conn.cursor()
        cursor.execute(
            "SELECT vector_embedding FROM embeddings WHERE tag = ? ORDER BY RANDOM() LIMIT 1;",
            (search_tag,),
        )
        result = cursor.fetchone()

    # Process result
    if result:
        vector_blob = result[0]  # Extract the first (and only) column from the tuple
        vector = pickle.loads(vector_blob)  # Deserialize

        if isinstance(vector, torch.Tensor):
            vector = vector.cpu().numpy()
        else:
            vector = np.array(vector)  # Convert non-tensor to NumPy array

        return vector

    else:
        print(f"No entries found for tag '{search_tag}'")

    return vector


def get_tags():

    # Connect to the database and fetch a random row
    with sqlite3.connect(db_path) as conn:
        cursor = conn.cursor()
        cursor.execute(
            "SELECT DISTINCT(tags) FROM embeddings",
        )
        result = cursor.fetchone()

    # Process result
    if result:
        filename, vector_blob = result
        vector = pickle.loads(vector_blob)  # Deserialize the embedding
        print(
            f"Random File: {filename}, Embedding (dim={len(vector)}): {vector[:5]}..."
        )  # Print first 5 dimensions
