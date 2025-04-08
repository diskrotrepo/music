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
import transformers
import torch
import os
import logging

lrc_pipeline = None
poet_pipeline = None

if torch.version.cuda is None:
    logging.warning("CUDA is not available. Please check your PyTorch installation.")

if os.getenv("LLM_SOURCE") == "huggingface":

    device = "cpu"

    if torch.cuda.is_available():
        device = "cuda"
        torch_dtype = torch.float16

    elif torch.mps.is_available():
        device = "mps"
        torch_dtype = torch.float32

    assert device != "cpu", "CPU is not supported for inference. Please use GPU or MPS."

    if lrc_pipeline is None:
        lrc_model_id = os.getenv("HF_LRC_MODEL")
        lrc_pipeline = transformers.pipeline(
            "text-generation",
            model=lrc_model_id,
            model_kwargs={"torch_dtype": torch_dtype},
            device_map=device,
        )
    logging.info(f"LRC Model {lrc_model_id} loaded successfully!")

    if poet_pipeline is None:
        poet_model_id = os.getenv("HF_POET_MODEL")
        poet_pipeline = transformers.pipeline(
            "text-generation",
            model=poet_model_id,
            model_kwargs={"torch_dtype": torch_dtype},
            device_map=device,
        )
        logging.info(f"Poet Model {poet_model_id} loaded successfully!")


db = SQLAlchemy()
migrate = Migrate()


def register_extensions(app):

    db.init_app(app)
    migrate.init_app(app, db)

    from music_inferencing.models import (
        Music,
        Prompt,
    )
