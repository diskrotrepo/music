from flask_restx import Namespace, Resource, fields
from flask import request, jsonify
from music_shared.lrc import get_default_lrc_prompt
import os
import requests
import logging

api = Namespace("status", description="Status related APIs")

status_response_model = api.model(
    "StatusResponse",
    {
        "id": fields.String(
            required=True,
            description="The id of the song in the queue",
            example="b7e6a5d9-5f42-4a8b-9a38-47ef2e2a8df1",
        ),
        "title": fields.String(
            required=True,
            description="Title for your song",
            example="Banger #1",
        ),
        "filename": fields.String(
            required=True,
            description="The filename of the song in the queue",
            example="s3://bucket/folder/song.wav",
        ),
        "dt_created": fields.DateTime(
            required=False,
            description="The date the song was created",
            example="2025-03-12T00:00:00+05:00",
        ),
        "processing_status": fields.String(
            required=True,
            description="Current status of the song in the queue",
            example="NEW",
        ),
    },
)


@api.route("/<string:id>")
class StatusController(Resource):

    @api.doc(
        description="Returns status of music generation in the queue",
        tags=["Queue Library"],
    )
    @api.response(200, "Success", status_response_model)
    def get(self, id):
        """Retrieve queue status."""
        try:

            base_url = os.environ.get("MUSIC_QUEUE_URL")
            port = os.environ.get("MUSIC_QUEUE_PORT")
            endpoint = f"/api/v1/status/{id}"

            check_status_url = f"{base_url}:{port}{endpoint}"

            logging.info(f"Checking status of song with id: {id}")

            response = requests.get(check_status_url)

            if response.status_code != 200:
                return {
                    "error": f"No song found at {check_status_url}"
                }, response.status_code

            return response.json(), 200

        except Exception as e:
            return {"error": str(e)}, 500
