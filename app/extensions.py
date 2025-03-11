from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

from celery import Celery

db = SQLAlchemy()
migrate = Migrate()
celery = Celery()


def register_extensions(app, worker=False):
    db.init_app(app)
    migrate.init_app(app, db)

    # load celery config
    celery.config_from_object(app.config)

    if not worker:
        from app.models import (
            Music,
            Prompt,
        )

        pass
