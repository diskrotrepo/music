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
from music_inferencing.models import Prompt, PromptyCategoryEnum
from music_inferencing.extensions import db
import os

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


def get_default_poet_prompt():
    """Reads the poet prompt from music_backend/config/poetDefault.txt."""

    prompt_path = os.path.join("config", "poetDefault.txt")

    try:
        with open(prompt_path, "r", encoding="utf-8") as file:
            return file.read().strip()
    except FileNotFoundError:
        print(f"Error: Missing {prompt_path}")
        return None
    except Exception as e:
        print(f"Error reading {prompt_path}: {e}")
        return None
