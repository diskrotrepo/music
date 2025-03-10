import sqlite3
import pickle

# Database path
db_path = "embeddings.db"

# Tag to search for
search_tag = "rock"  # Change this to any tag you want

# Connect to the database and fetch a random row
with sqlite3.connect(db_path) as conn:
    cursor = conn.cursor()
    cursor.execute(
        "SELECT filename, vector_embedding FROM embeddings WHERE tag = ? ORDER BY RANDOM() LIMIT 1;",
        (search_tag,),
    )
    result = cursor.fetchone()

# Process result
if result:
    filename, vector_blob = result
    vector = pickle.loads(vector_blob)  # Deserialize the embedding
    print(
        f"Random File: {filename}, Embedding (dim={len(vector)}): {vector[:5]}..."
    )  # Print first 5 dimensions
else:
    print(f"No entries found for tag '{search_tag}'")
