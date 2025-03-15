# Copyright (c) 2025 diskrot
#               2025 Alex Ayers   (alex.ayers@diskrot.com)
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os


def get_default_lrc_prompt():
    """Reads the lyric prompt from music_shared/config/lrcDefault.txt."""
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.abspath(os.path.join(script_dir, ".."))
    prompt_path = os.path.join(project_root, "music_shared", "config", "lrcDefault.txt")

    try:
        with open(prompt_path, "r", encoding="utf-8") as file:
            return file.read().strip()
    except FileNotFoundError:
        print(f"Error: Missing {prompt_path}")
        return None
    except Exception as e:
        print(f"Error reading {prompt_path}: {e}")
        return None
