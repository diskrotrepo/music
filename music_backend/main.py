from music_backend.music_backend import create_app
import os
import logging

app = create_app()

if __name__ == "__main__":
    port = os.getenv("MUSIC_BACKEND_PORT")
    logging.info("--------|diskrot|---------")
    logging.info(f"Starting Music Backend on port {port}")
    app.run(debug=True, host="0.0.0.0", port=port)
