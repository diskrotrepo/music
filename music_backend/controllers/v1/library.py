# Copyright (c) 2025 diskrot
#               2025 Alex Ayers   (alex.ayers@diskrot.com)
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from enum import Enum
from flask_restx import Namespace, Resource, fields
from flask import request
from music_backend.extensions import db
from music_backend.models import Music
import logging

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
        "status": fields.String(
            required=True,
            description="Current status of the song in the library",
            example="NEW",
        ),
    },
)


@api.route("")
class LibraryController(Resource):

    @api.doc(
        description="Filters songs based on list_view (library or trash) and optional favorite filter.",
        params={
            "list_view": "Required: 'library' (is_deleted=False) or 'trash' (is_deleted=True)",
            "favorite": "Optional: true or false to filter favorites",
        },
        tags=["Music Library"],
    )
    @api.response(200, "Success", [library_definition])
    def get(self):
        """Retrieve songs based on list_view and optional favorite filter."""
        try:
            list_view = request.args.get("list_view")
            favorite_filter = request.args.get("favorite")

            # Validate list_view
            if list_view not in {"library", "trash"}:
                return {"error": "Invalid list_view. Must be 'library' or 'trash'"}, 400

            # Determine is_deleted filter based on list_view
            if list_view == "trash":
                is_deleted = True
            else:
                is_deleted = False

            # Base query
            query = db.session.query(Music).filter_by(is_deleted=is_deleted)

            # Apply optional favorite filter
            if favorite_filter is not None:
                query = query.filter_by(is_favorite=True)

            # Fetch results
            library = query.all()

            if not library:
                return {"error": "No songs found"}, 404

            # Format response
            library_list = [
                {
                    "id": song.id,
                    "title": song.title,
                    "filename": song.filename,
                    "dt_created": (
                        song.dt_created.isoformat() if song.dt_created else None
                    ),
                    "lyrics": song.lyrics,
                    "duration": song.duration,
                    "tags": song.prompt,
                    "negative_tags": (
                        song.negative_tags if hasattr(song, "negative_tags") else None
                    ),
                    "lrc_id": song.lrc_id if hasattr(song, "lrc_id") else None,
                    "is_favorite": song.is_favorite,
                    "is_deleted": song.is_deleted,
                    "processing_status": song.processing_status.value,
                }
                for song in library
            ]

            return {"library": library_list}, 200

        except Exception as e:
            return {"error": str(e)}, 500


class SongAction(str, Enum):
    FAVORITE = "favorite"
    DELETE = "delete"
    RESTORE = "restore"
    UNFAVORITE = "unfavorite"


@api.route("/song/<uuid:song>/action/<string:action>")
@api.doc(
    params={
        "song": "UUID of the song",
        "action": f"Action to perform ({', '.join([a.value for a in SongAction])})",
    }
)
class SongActionController(Resource):

    def update_song(self, songId, action):
        """Updates song in the database based on the action"""

        logging.info(songId)
        song = db.session.query(Music).filter_by(id=str(songId)).one_or_none()

        if not song:
            return {"error": "Song not found"}, 404

        match action:
            case SongAction.FAVORITE:
                song.is_favorite = True
            case SongAction.UNFAVORITE:
                song.is_favorite = False
            case SongAction.DELETE:
                song.is_deleted = True
            case SongAction.RESTORE:
                song.is_deleted = False
            case _:
                return {"error": "Invalid action"}, 400

        db.session.commit()
        return {"success": True}, 200

    @api.doc(
        description="Handles song actions such as favorite, delete, restore, and unfavorite.",
        tags=["Music Library"],
    )
    @api.response(200, "Success")
    def post(self, song, action):
        """Handles actions for a specific song"""
        try:
            if action not in SongAction._value2member_map_:
                return {"error": "Invalid action"}, 400

            return self.update_song(song, action)

        except Exception as e:
            return {"error": str(e)}, 500
