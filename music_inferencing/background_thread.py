# Copyright (c) 2025 diskrot
#               2025 Alex Ayers   (alex.ayers@diskrot.com)
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import enum
import logging
import queue
import threading
import time
from queue import Queue
from abc import abstractmethod, ABC
from typing import Dict
import os

from diffrhythm.infer.infer import generate
from music_inferencing.models import Music, MusicProcessingEnum, Prompt
from music_inferencing.extensions import db
from music_inferencing.s3_storage import upload_file


TASKS_QUEUE = Queue()

PROJECT_ROOT_DIR = os.path.abspath(os.path.dirname(__file__)).replace(
    "music_inferencing", ""
)


class BackgroundThread(threading.Thread, ABC):
    def __init__(self):
        super().__init__()
        self._stop_event = threading.Event()

    def stop(self) -> None:
        self._stop_event.set()

    def _stopped(self) -> bool:
        return self._stop_event.is_set()

    @abstractmethod
    def startup(self) -> None:
        pass

    @abstractmethod
    def shutdown(self) -> None:
        pass

    @abstractmethod
    def handle(self) -> None:
        pass

    def run(self) -> None:
        self.startup()
        while not self._stopped():
            self.handle()
        self.shutdown()


class InferenceThread(BackgroundThread):

    def __init__(self, app):
        super().__init__()
        self.app = app

    def startup(self) -> None:
        logging.info("InferenceThread started")

    def shutdown(self) -> None:
        logging.info("InferenceThread stopped")

    def handle(self) -> None:
        try:

            with self.app.app_context():

                query = db.session.query(Music).filter_by(
                    processing_status=MusicProcessingEnum.NEW
                )
                songs = query.all()

                for song in songs:
                    song.processing_status = MusicProcessingEnum.IN_PROGRESS
                    db.session.commit()
                    logging.info(f"Processing song {song.id}")

                    file_path = generate(
                        lyrics=song.lyrics,
                        input_file=song.input_file,
                        audio_length=song.duration,
                        steps=song.steps,
                        cfg_strength=song.cfg_strength,
                        chunked=True,
                        tags=song.prompt,
                        lrc_prompt=Prompt(prompt=song.lrc_prompt, model=song.lrc_model),
                        negative_tags=song.negative_prompt,
                        use_embeddings=False,
                    )

                    s3_enabled = os.environ.get("S3_ENABLED")

                    if s3_enabled == "true":
                        logging.info(f"Uploading song {file_path} to S3")
                        with open(file_path, "rb") as f:
                            file_data = f.read()
                            upload_file(
                                file_data,
                                os.environ.get("S3_BUCKET_NAME"),
                                song.filename,
                            )

                        os.remove(file_path)

                        song.filename = (
                            f"s3://{os.environ.get('S3_BUCKET_NAME')}/{song.filename}"
                        )
                    else:
                        song.filename = file_path

                    song.processing_status = MusicProcessingEnum.COMPLETE
                    db.session.commit()
                    logging.info(f"Completed song {song.id}")
        except queue.Empty:
            time.sleep(1)


class BackgroundThreadType(enum.Enum):
    INFERENCE = "inference"


class BackgroundThreadFactory:
    @staticmethod
    def create(thread_type: BackgroundThreadType, app=None) -> BackgroundThread:
        if thread_type == BackgroundThreadType.INFERENCE:
            return InferenceThread(app)
