# Copyright (c) 2025 diskrot
#               2025 Alex Ayers   (alex.ayers@diskrot.com)
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from flask import Flask
from flask_cors import CORS
from music_backend.config import config
from music_backend.extensions import register_extensions
from music_backend.apiv1 import blueprint as api1


def create_app():
    app = Flask(
        __name__,
    )
    CORS(app, resources={r"/api/*": {"origins": "*"}})

    app.config.from_object(config)
    app.register_blueprint(api1)

    register_extensions(app)

    return app
