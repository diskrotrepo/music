from app.extensions import db
import uuid
import enum
from datetime import datetime


class Music(db.Model):
    id = db.Column(db.String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    filename = db.Column(db.String(255), nullable=False, default="")
    title = db.Column(db.String(255), nullable=False, default="")
    lyrics = db.Column(db.String(3000), nullable=False, default="")
    prompt = db.Column(db.String(2048), nullable=False, default="")
    model = db.Column(db.String(128), nullable=False, default="")
    steps = db.Column(db.Integer, nullable=False, default="")
    cfg_strength = db.Column(db.Float, nullable=False, default="")
    duration = db.Column(db.Integer, nullable=False, default="")
    dtCreated = db.Column(db.DateTime, nullable=False, default=datetime.now())


class PromptyCategoryEnum(enum.Enum):
    LRC = "LRC"
    POET = "POET"


class Prompt(db.Model):
    id = db.Column(db.String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    prompt = db.Column(db.String(2048), nullable=False, default="")
    category = db.Column(db.Enum(PromptyCategoryEnum), nullable=False)
    model = db.Column(db.String(128), nullable=False, default="")
    is_default = db.Column(db.Boolean, nullable=False, default=False)
    dtCreated = db.Column(db.DateTime, nullable=False, default=datetime.now())
