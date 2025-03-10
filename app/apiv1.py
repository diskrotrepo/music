from flask import Blueprint
from flask_restx import Api


from .apis.music import api as music_api

blueprint = Blueprint("api", __name__, url_prefix="/api/v1")

api = Api(
    blueprint,
    title="diskrot: Music Generation",
    version="1.0",
    description="A local way to explore the latent space of sound",
    doc="/doc/",
)

api.add_namespace(music_api)
