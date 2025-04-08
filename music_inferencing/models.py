# Copyright (c) 2025 diskrot
#               2025 Alex Ayers   (alex.ayers@diskrot.com)
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from music_inferencing.extensions import db
import uuid
import enum
from datetime import datetime


class MusicProcessingEnum(enum.Enum):
    NEW = "NEW"
    IN_PROGRESS = "IN_PROGRESS"
    COMPLETE = "COMPLETE"


class Music(db.Model):
    id = db.Column(db.String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    filename = db.Column(db.String(255), nullable=False, default="")
    title = db.Column(db.String(255), nullable=False, default="")
    lyrics = db.Column(db.String(3000), nullable=True)
    prompt = db.Column(db.String(2048), nullable=False, default="")
    negative_prompt = db.Column(db.String(2048), nullable=True)
    input_file = db.Column(db.String(2048), nullable=True)
    model = db.Column(db.String(128), nullable=False, default="")
    steps = db.Column(db.Integer, nullable=False, default="")
    cfg_strength = db.Column(db.Float, nullable=False, default="")
    duration = db.Column(db.Integer, nullable=False, default="")
    dt_created = db.Column(db.DateTime, nullable=False, default=datetime.now())
    is_favorite = db.Column(db.Boolean, nullable=False, default=False)
    is_deleted = db.Column(db.Boolean, nullable=False, default=False)
    inference_server = db.Column(db.String(256), nullable=False, default="")
    lrc_prompt = db.Column(db.String(2048), nullable=False, default="")
    lrc_model = db.Column(db.String(256), nullable=False, default="")
    shared_secret = db.Column(db.String(256), nullable=False, default="")
    requesting_client_id = db.Column(db.String(256), nullable=False, default="")
    processing_status = db.Column(
        db.Enum(MusicProcessingEnum), nullable=False, default=MusicProcessingEnum.NEW
    )


class PromptyCategoryEnum(enum.Enum):
    LRC = "LRC"
    POET = "POET"


class Prompt(db.Model):
    id = db.Column(db.String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    prompt = db.Column(db.String(2048), nullable=False, default="")
    category = db.Column(db.Enum(PromptyCategoryEnum), nullable=False)
    model = db.Column(db.String(128), nullable=False, default="")
    is_default = db.Column(db.Boolean, nullable=False, default=False)
    dt_created = db.Column(db.DateTime, nullable=False, default=datetime.now())
