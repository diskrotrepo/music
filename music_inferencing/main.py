import os
from music_inferencing.music_queue import create_app

app = create_app()


if __name__ == "__main__":
    port = int(os.getenv("MUSIC_QUEUE_PORT", "5001"))

    app.run(host="0.0.0.0", port=5001, debug=True)
