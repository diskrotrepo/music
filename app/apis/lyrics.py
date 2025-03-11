from flask_restx import Namespace, Resource, fields
from flask import request, jsonify


api = Namespace("lyrics", description="Lyric related APIs")


lyric_definition = api.model(
    "Lyric",
    {
        "prompt": fields.String(
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
class LyricsGeneratorV1(Resource):

    @api.expect(lyric_definition, True)
    @api.response(200, "Success", lyric_generated_response)
    def post(self):
        try:
            # Get parameters from the request
            data = request.json or {}

            prompt = data.get("prompt")

            return {"success": True}, 200

        except Exception as e:
            return {"error": str(e)}, 500

    @api.response(200, "Success")
    def get(self):
        try:

            return {"id": "ok"}, 200

        except Exception as e:
            return {"error": str(e)}, 500
