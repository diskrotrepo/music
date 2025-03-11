from app.extensions import db
import uuid
import enum


class Music(db.Model):
    id = db.Column(db.String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    filename = db.Column(db.String(255), nullable=False)


class PromptyCategoryEnum(enum.Enum):
    LRC = "lrc"
    POET = "poet"


class Prompt(db.Model):
    id = db.Column(db.String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    prompt = db.Column(db.String(2048), nullable=False)
    category = db.Column(db.Enum(PromptyCategoryEnum), nullable=False)
    model = db.Column(db.String(128), nullable=False)
    is_default = db.Column(db.Boolean, nullable=False, default=False)
