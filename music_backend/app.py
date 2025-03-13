from flask import Flask
from flask_cors import CORS
from music_backend.config import config
from music_backend.extensions import register_extensions
from music_backend.apiv1 import blueprint as api1


def create_app():
    app = Flask(
        __name__,
    )
    CORS(app, resources={r"/api/*": {"origins": "http://localhost:5173"}})

    app.config.from_object(config)
    app.register_blueprint(api1)

    register_extensions(app)

    return app
