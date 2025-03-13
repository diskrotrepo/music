from music_backend import create_app
import os

app = create_app()

if __name__ == "__main__":
    port = os.getenv("MUSIC_BACKEND_PORT")
    app.run(debug=True, host="0.0.0.0", port=port)
