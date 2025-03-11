from flask import Flask
from app.extensions import db, migrate

from app.apiv1 import blueprint as api1


def create_app():
    app = Flask(__name__)

    app.config.from_object("app.config.Config")
    app.register_blueprint(api1)

    register_extensions(app)

    return app


def register_extensions(app):
    db.init_app(app)
    migrate.init_app(app, db)
    from app.models import Music
