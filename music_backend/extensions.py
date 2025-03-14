from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
import logging

import os


db = SQLAlchemy()
migrate = Migrate()

logging.basicConfig()
logging.getLogger("sqlalchemy.engine").setLevel(logging.INFO)


def register_extensions(app):

    db.init_app(app)
    migrate.init_app(app, db)

    from music_shared.models import (
        Music,
        Prompt,
    )
