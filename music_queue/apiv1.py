from flask import Blueprint
from flask_restx import Api

from music_queue.controllers.v1.status import api as status_api

blueprint = Blueprint("api", __name__, url_prefix="/api/v1")

api = Api(
    blueprint,
    title="diskrot: Music Queue",
    version="1.0",
    description="A local way to explore the latent space of sound",
    doc="/docs/",
)

api.add_namespace(status_api)

