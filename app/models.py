from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

db = SQLAlchemy()

# db.init_app(app)
# Migrate(app, db)


class Music(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    filename = db.Column(db.String(255), nullable=False)


def __init__(self, filename):
    self.filename = filename
