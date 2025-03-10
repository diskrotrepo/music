from flask_restx import Namespace, Resource, fields
from flask import request, jsonify


api = Namespace("lyrics", description="Lyric related APIs")

lrc_definition = api.model(
    "LRC",
    {
        "prompt": fields.String(
            required=True,
            description="Lyrics for your song",
            example="""Take the input, and produce an Simple LRC format file which takes into account time required to sing the previous line. 
            Time tags have the format [mm:ss.xx]lyric , where mm is minutes, ss is seconds, xx is hundredths of a second, 
            and lyric is the lyric to be played at that time. Do not provide any other information. I require just the file.

            Example output:

            [00:12.00]Line 1 lyrics
            [00:17.20]Line 2 lyrics""",
        ),
    },
)

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

llm_update_response = api.model(
    "LLMResponse",
    {
        "success": fields.Boolean(
            description="The update was successful",
            example=True,
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


@api.route("/lrc")
class LyricsLrcV1(Resource):

    @api.expect(lrc_definition, True)
    @api.response(200, "Success", llm_update_response)
    def post(self):
        try:
            # Get parameters from the request
            data = request.json or {}

            prompt = data.get("prompt")

            return {"success": True}, 200

        except Exception as e:
            return jsonify({"error": str(e)}), 500

    @api.response(200, "Success")
    def get(self):
        try:

            return {"id": "ok"}, 200

        except Exception as e:
            return jsonify({"error": str(e)}), 500


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
            return jsonify({"error": str(e)}), 500

    @api.response(200, "Success")
    def get(self):
        try:

            return {"id": "ok"}, 200

        except Exception as e:
            return jsonify({"error": str(e)}), 500
