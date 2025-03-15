# Copyright (c) 2025 diskrot
#               2025 Alex Ayers   (alex.ayers@diskrot.com)
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os


class Config:
    DEBUG = False
    PROJECT_ROOT_DIR = os.path.abspath(os.path.dirname(__file__)).replace(
        "/music_inference", ""
    )
    BASE_DIR = os.path.abspath(os.path.dirname(__file__))
    SQLALCHEMY_DATABASE_URI = (
        f"sqlite:///{os.path.join(PROJECT_ROOT_DIR, 'database', 'diskrot.db')}"
    )
    PORT = os.getenv("MUSIC_QUEUE_PORT", "5001")
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    HF_LRC_MODEL = os.getenv("HF_LRC_MODEL")
    SCHEDULER_API_ENABLED = True


class DevelopmentConfig(Config):
    DEBUG = True


class ProductionConfig(Config):
    pass


available_configs = dict(development=DevelopmentConfig, production=ProductionConfig)
selected_config = os.getenv("FLASK_ENV", "production")
config = available_configs.get(selected_config, "production")
