# Copyright (c) 2025 diskrot
#               2025 Alex Ayers   (alex.ayers@diskrot.com)
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
import logging

import os


db = SQLAlchemy()
migrate = Migrate()

logging.basicConfig()
logging.getLogger("sqlalchemy.engine").setLevel(logging.INFO)


def register_extensions(app):

    from music_backend.models import (
        Music,
        Prompt,
    )

    db.init_app(app)
    migrate.init_app(app, db)
