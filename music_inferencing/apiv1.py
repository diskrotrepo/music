# Copyright (c) 2025 diskrot
#               2025 Alex Ayers   (alex.ayers@diskrot.com)
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from flask import Blueprint
from flask_restx import Api

from music_inferencing.controllers.v1.status import api as status_api

blueprint = Blueprint("api", __name__, url_prefix="/api/v1")

api = Api(
    blueprint,
    title="diskrot: Music Queue",
    version="1.0",
    description="A local way to explore the latent space of sound",
    doc="/docs/",
)

api.add_namespace(status_api)
