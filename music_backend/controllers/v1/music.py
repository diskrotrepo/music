from flask_restx import Namespace, Resource, fields
from flask import request
import requests
import uuid
import os
import logging

from music_backend.extensions import db
from music_shared.models import Music


api = Namespace("music", description="Music related APIs")

music_definition = api.model(
    "Music",
    {
        "title": fields.String(
            required=True,
            description="Title for your song",
            example="Banger #1",
        ),
        "lyrics": fields.String(
            required=False,
            description="Lyrics for your song",
            example="I am a song. (la la la)",
        ),
        "duration": fields.Integer(
            required=True,
            description="The maximum length of the generated audio",
            example=95,
        ),
        "steps": fields.Integer(
            required=True,
            description="The total steps used during the generation",
            example=32,
        ),
        "cfg_strength": fields.Integer(
            required=True,
            description="The amount of your cfg plays into blah blah",
            example=6.0,
        ),
        "chunked": fields.Boolean(
            required=True,
            description="Whether or not you file is generated in chunks",
            example=True,
        ),
        "tags": fields.String(
            required=True,
            description="The style tags used to generate your music",
            example="rock and roll, hip hop",
        ),
        "negative_tags": fields.String(
            required=False,
            description="The negative style tags used to generate your music",
            example="heavy metal, noise",
        ),
        "lrc_id": fields.String(
            required=False,
            description="The LRC system prompt id applied to the incoming lyrics",
            example="b7e6a5d9-5f42-4a8b-9a38-47ef2e2a8df1",
        ),
    },
)

music_response_model = api.model(
    "MusicResponse",
    {
        "id": fields.String(
            description="Unique identifier for the music generation task",
            example="b7e6a5d9-5f42-4a8b-9a38-47ef2e2a8df1",
        ),
    },
)


@api.route("/generate")
class MusicGenerationController(Resource):

    @api.doc(description="Generates music", tags=["Music"])
    @api.expect(music_definition, True)
    @api.response(200, "Success", music_response_model)
    def post(self):
        try:
            data = request.json or {}

            base_url = os.environ.get("MUSIC_QUEUE_URL")
            port = os.environ.get("MUSIC_QUEUE_PORT")
            endpoint = "/task"

            submit_task_url = f"{base_url}:{port}{endpoint}"

            logging.info(f"Submitting task to {submit_task_url}")

            try:
                response = requests.post(
                    submit_task_url,
                    json={
                        "lyrics": data.get("lyrics"),
                        "duration": data.get("duration"),
                        "steps": data.get("steps"),
                        "title": data.get("title"),
                        "cfg_strength": data.get("cfg_strength"),
                        "tags": data.get("tags"),
                        "negative_tags": data.get("negative_tags"),
                    },
                )

                task_id = response.json().get("id")

                new_music = Music(
                    id=task_id,
                    filename="not available",
                    title=data.get("title"),
                    lyrics=data.get("lyrics"),
                    prompt=data.get("tags"),
                    negative_prompt=data.get("negative_tags"),
                    input_file=data.get("input"),
                    duration=data.get("duration"),
                    steps=data.get("steps"),
                    cfg_strength=data.get("cfg_strength"),
                    model="unknown",
                )

                db.session.add(new_music)
                db.session.commit()

                return {"id": task_id}
            except Exception as e:
                return {
                    "error": f"Unable to submit task to inference server {submit_task_url} - {str(e)}"
                }, 500

        except Exception as e:
            return {"error": str(e)}, 500
