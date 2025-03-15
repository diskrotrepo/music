# Copyright (c) 2025 diskrot
#               2025 Alex Ayers   (alex.ayers@diskrot.com)
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os
from music_inferencing.music_queue import create_app

app = create_app()


if __name__ == "__main__":
    port = int(os.getenv("MUSIC_QUEUE_PORT", "5001"))

    app.run(host="0.0.0.0", port=5001, debug=True)
