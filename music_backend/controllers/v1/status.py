# Copyright (c) 2025 diskrot
#               2025 Alex Ayers   (alex.ayers@diskrot.com)
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from flask_restx import Namespace, Resource, fields
from music_backend.models import Music
import os
import requests
import logging
from music_backend.extensions import db

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

            if response.json().get("processing_status") == "COMPLETE":
                data = response.json()
                data["filename"] = data["filename"].replace("s3://", "")

                db.session.query(Music).filter_by(id=id).update(
                    {"processing_status": "COMPLETE", "filename": data["filename"]}
                )
                db.session.commit()

                return data, 200

            return response.json(), 200

        except Exception as e:
            return {"error": str(e)}, 500
