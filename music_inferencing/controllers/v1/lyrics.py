from flask_restx import Namespace, Resource, fields
from flask import request
from music_backend.lyrics import write_lyrics
from music_inferencing.models import Prompt, PromptyCategoryEnum
from music_backend.extensions import db
from music_backend.controllers.v1.prompt import get_default_poet_prompt


api = Namespace("lyrics", description="Lyric related APIs")

lyric_definition = api.model(
    "Lyric",
    {
        "lyrics": fields.String(
            required=True,
            description="Lyrics for your song",
            example="""Take the input and create an amazing pop song from the existing lyrics.""",
        ),
    },
)

lyric_generated_response = api.model(
    "LyricResponse",
    {
        "success": fields.Boolean(
            description="The update was successful",
            example="""Girl, you're my g-g-g-g-girl.""",
        ),
    },
)


@api.route("/poet")
class PoetController(Resource):

    @api.doc(description="For a given promp generate lyrics", tags=["Lyrics"])
    @api.expect(lyric_definition, True)
    @api.response(200, "Success", lyric_generated_response)
    def post(self):
        try:
            data = request.json or {}
            lyrics = data.get("lyrics")

            poetPrompt = (
                db.session.query(Prompt)
                .filter_by(category=PromptyCategoryEnum.POET, is_default=True)
                .one_or_none()
            )

            if poetPrompt is None:
                poetPrompt = get_default_poet_prompt()

            poetLyrics = write_lyrics(lyrics, poetPrompt)

            return {"lyrics": poetLyrics}, 200

        except Exception as e:
            return {"error": str(e)}, 500
