from flask_restx import Namespace, Resource, fields
from flask import request, jsonify
from app.extensions import db
from app.models import Music, Prompt, PromptyCategoryEnum
from infer import generate

api = Namespace("library", description="Library related APIs")

library_definition = api.model(
    "Library",
    {
        "title": fields.String(
            required=True,
            description="Title for your song",
            example="Banger #1",
        ),
        "dt_created": fields.DateTime(
            required=False,
            description="The date the song was created",
            example="2025-03-12T00:00:00+05:00",  
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

@api.route("/")
class LibraryV1(Resource):

    @api.doc("generate_music_v1")
    @api.response(200, "Success", [library_definition])  # Fixed list format
    def get(self):
        try:
            
            library = db.session.query(Music).all()

            if not library:
                return {"error": "No songs found"}, 404  # Return 404 if not found

            library_list = [
                {
                    "id": song.id,
                    "filename": song.filename,
                    "title": song.title,
                    "dt_created": song.dt_created.isoformat() if song.dt_created else None,
                    "lyrics": song.lyrics,
                    "duration": song.duration,
                    "tags": song.prompt,
                    "negative_tags": song.negative_tags if hasattr(song, "negative_tags") else None,
                    "lrc_id": song.lrc_id if hasattr(song, "lrc_id") else None,
                }
                for song in library
            ]
        
            return {"library": library_list}, 200

        except Exception as e:
            return {"error": str(e)}, 500
      