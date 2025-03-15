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
from music_shared.lrc import get_default_lrc_prompt
from music_shared.models import Music, MusicProcessingEnum, Prompt
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

                    query = (
                        db.session.query(Prompt)
                        .filter_by(is_default=True)
                        .filter_by(category="LRC")
                    )
                    lrcPromptResult = query.first()

                    if lrcPromptResult == None:
                        model = os.environ.get("LLM_MODEL")
                        lrcPrompt = Prompt(
                            prompt=get_default_lrc_prompt(),
                            category="LRC",
                            model=model,
                            is_default=True,
                        )
                    else:
                        lrcPrompt = lrcPromptResult

                    generate(
                        lyrics=song.lyrics,
                        input_file=song.input_file,
                        audio_length=song.duration,
                        steps=song.steps,
                        cfg_strength=song.cfg_strength,
                        chunked=True,
                        tags=song.prompt,
                        lrcPrompt=lrcPrompt,
                        negative_tags=song.negative_prompt,
                        use_embeddings=False,
                    )

                    file_path = os.path.join(
                        PROJECT_ROOT_DIR, "music_output", f"{song.id}.wav"
                    )

                    s3_enabled = os.environ.get("S3_ENABLED")

                    if s3_enabled == "true":
                        logging.info(f"Uploading song {song.id} to S3")
                        with open(file_path, "rb") as f:
                            file_data = f.read()
                            upload_file(
                                file_data,
                                os.environ.get("S3_BUCKET_NAME"),
                                song.filename,
                            )

                        os.remove(file_path)

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
