from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from app.config import Config

from app.apiv1 import blueprint as api1

db = SQLAlchemy()
migrate = Migrate()


def create_app():
    app = Flask(__name__)

    app.config.from_object("app.config.Config")

    db.init_app(app)
    migrate.init_app(app, db)

    app.register_blueprint(api1)

    return app
