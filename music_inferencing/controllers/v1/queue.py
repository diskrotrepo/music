# Copyright (c) 2025 diskrot
#               2025 Alex Ayers   (alex.ayers@diskrot.com)
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from flask_restx import Namespace, Resource, fields
from flask import request
from music_inferencing.extensions import db
from music_inferencing.models import Music

api = Namespace("queue", description="Queue related APIs")

queue_status_definition = api.model(
    "Queue Status",
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
class QueueController(Resource):

    @api.doc(
        description="Returns status of music generation in the queue",
        tags=["Queue Library"],
    )
    @api.response(200, "Success", [queue_status_definition])
    def get(self, id):
        """Retrieve queue status."""
        try:

            # Base query
            query = db.session.query(Music).filter_by(id=id)

            # Fetch results
            song = query.one_or_none()

            if not song:
                return {"error": "No song found"}, 404

            return {
                "id": song.id,
                "title": song.title,
                "dt_created": (
                    song.dt_created.isoformat() if song.dt_created else None
                ),
                "filename": song.filename,
                "processing_status": song.processing_status.value,
            }, 200

        except Exception as e:
            return {"error": str(e)}, 500

    @api.doc(
        description="Removes task from queue",
        tags=["Queue Library"],
    )
    @api.response(200, "Success")
    def get(self, id):
        """Retrieve queue status."""
        try:

            music = db.session.query(Music).get(id)
            if music:
                db.session.delete(music)
                db.session.commit()

                return {
                    "success": True,
                }, 200
            else:
                return {
                    "error": "No song found",
                }, 404

        except Exception as e:
            return {"error": str(e)}, 500
