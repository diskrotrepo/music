from flask_restx import Namespace, Resource, fields
from flask import request, jsonify, send_from_directory
from app.tasks import generate_music_task
from infer import generate
import os

from app.extensions import db
from app.models import (
    Music,
    Prompt,
    PromptyCategoryEnum,
)


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
class MusicGenerationV1(Resource):

    @api.doc(description="Generates music", tags=["Music"])
    @api.expect(music_definition, True)
    @api.response(200, "Success", music_response_model)
    def post(self):
        try:
            # Get parameters from the request
            data = request.json or {}
            lrc_id = data.get("lrc_id", None)

            if lrc_id is None:
                lrcPrompt = (
                    db.session.query(Prompt)
                    .filter_by(category=PromptyCategoryEnum.LRC, is_default=True)
                    .first()
                )
            else:
                lrcPrompt = db.session.get(Prompt, lrc_id)

            if not lrcPrompt:
                lrcPrompt = get_default_lrc_prompt

            generation_id = generate(
                lyrics=data.get("lyrics", ""),
                lrcPrompt=lrcPrompt,
                input_file=data.get("input"),
                audio_length=data.get("duration"),
                steps=data.get("steps"),
                cfg_strength=data.get("cfg_strength"),
                chunked=data.get("chunked"),
                tags=data.get("tags"),
                negative_tags=data.get("negative_tags"),
                use_embeddings=data.get("use_embedding", False),
            )

            new_music = Music(
                filename=f"{generation_id}.wav",
                title=data.get("title"),
                lyrics=data.get("lyrics"),
                prompt=data.get("tags"),
                negative_prompt = data.get("negative_tags"),
                input_file = data.get("input"),
                duration=data.get("duration"),
                steps=data.get("steps"),
                cfg_strength=data.get("cfg_strength"),
                model="unknown",
            )

            db.session.add(new_music)
            db.session.commit()

            return {"id": generation_id}

        except Exception as e:
            return {"error": str(e)}, 500


def get_default_lrc_prompt():
    """Reads the lyric prompt from app/config/lyricPrompt.txt."""
    prompt_path = os.path.join("app", "config", "lyricPrompt.txt")

    try:
        with open(prompt_path, "r", encoding="utf-8") as file:
            return file.read().strip()
    except FileNotFoundError:
        print(f"Error: Missing {prompt_path}")
        return None
    except Exception as e:
        print(f"Error reading {prompt_path}: {e}")
        return None