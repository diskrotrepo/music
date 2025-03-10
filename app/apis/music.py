from flask_restx import Namespace, Resource, fields
from flask import request, jsonify
from infer import generate


api = Namespace("music", description="Music related APIs")

music_definition = api.model(
    "Music",
    {
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
    },
)

music_response_model = api.model(
    "MusicResponse",
    {
        "id": fields.String(
            description="Unique identifier for the generated music",
            example="b7e6a5d9-5f42-4a8b-9a38-47ef2e2a8df1",
        ),
    },
)


@api.route("/generate")
class MusicGenerationV1(Resource):

    @api.doc("generate_music_v1")
    @api.expect(music_definition, True)
    @api.response(200, "Success", music_response_model)
    def post(self):
        try:
            # Get parameters from the request
            data = request.json or {}
            lyrics = data.get("lyrics", "")
            input_file = data.get("input")
            audio_length = data.get("duration")
            steps = data.get("steps")
            cfg_strength = data.get("cfg_strength")
            chunked = data.get("chunked")
            tags = data.get("tags")
            negative_tags = data.get("negative_tags")
            use_embedding = data.get("use_embedding", False)

            generation_id = generate(
                lyrics,
                input_file,
                audio_length,
                steps,
                cfg_strength,
                chunked,
                tags,
                negative_tags,
                use_embedding,
            )

            # Return the output
            return {"id": generation_id}, 200

        except Exception as e:
            return jsonify({"error": str(e)}), 500
