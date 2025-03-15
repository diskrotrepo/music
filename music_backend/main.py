# Copyright (c) 2025 diskrot
#               2025 Alex Ayers   (alex.ayers@diskrot.com)
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from music_backend.music_backend import create_app
import os
import logging

app = create_app()

if __name__ == "__main__":
    port = os.getenv("MUSIC_BACKEND_PORT")
    logging.info("--------|diskrot|---------")
    logging.info(f"Starting Music Backend on port {port}")
    app.run(debug=True, host="0.0.0.0", port=port)
