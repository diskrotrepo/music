from flask import Flask
from flask_cors import CORS
from app.config import config
from app.extensions import register_extensions
from app.apiv1 import blueprint as api1


def create_app():
    app = Flask(
        __name__,
    )
    CORS(app, resources={r"/*": {"origins": "*"}})

    app.config.from_object(config)
    app.register_blueprint(api1)

    register_extensions(app)

    return app


def create_worker_app():
    """Minimal App without routes for celery worker."""
    app = Flask(
        __name__,
    )
    app.config.from_object(config)

    register_extensions(app, worker=True)

    return app
