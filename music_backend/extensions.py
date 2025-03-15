from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
import logging

import os


db = SQLAlchemy()
migrate = Migrate()

logging.basicConfig()
logging.getLogger("sqlalchemy.engine").setLevel(logging.INFO)


def register_extensions(app):

    from music_backend.models import (
        Music,
        Prompt,
    )

    db.init_app(app)
    migrate.init_app(app, db)
