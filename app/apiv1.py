from flask import Blueprint
from flask_restx import Api

from app.controllers.music import api as music_api
from app.controllers.lyrics import api as lyric_api
from app.controllers.prompt import api as prompt_api
from app.controllers.library import api as library_api

blueprint = Blueprint("api", __name__, url_prefix="/api/v1")

api = Api(
    blueprint,
    title="diskrot: Music Generation",
    version="1.0",
    description="A local way to explore the latent space of sound",
    doc="/docs/",
)

api.add_namespace(music_api)
api.add_namespace(lyric_api)
api.add_namespace(prompt_api)
api.add_namespace(library_api)
