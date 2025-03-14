import enum
import logging
import queue
import threading
import time
from queue import Queue
from abc import abstractmethod, ABC
from typing import Dict

from diffrhythm.infer.infer import generate
from music_shared.lrc import get_default_lrc_prompt
from music_shared.models import Music, MusicProcessingEnum, Prompt
from music_queue.extensions import db


TASKS_QUEUE = Queue()


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
                task = TASKS_QUEUE.get(block=False)
                query = db.session.query(Music).filter_by(
                    processing_status=MusicProcessingEnum.NEW
                )
                songs = query.all()

                logging.info("InferenceThread processing song")

                for song in songs:
                    song.status = MusicProcessingEnum.IN_PROGRESS
                    db.session.commit()
                    logging.info(f"Processing song {song.id}")

                    query = (
                        db.session.query(Prompt)
                        .filter_by(is_default=True)
                        .filter_by(category="LRC")
                    )
                    lrcPrompt = query.first()

                    if lrcPrompt == None:
                        lrcPrompt = get_default_lrc_prompt()

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

                    song.status = MusicProcessingEnum.COMPLETE
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
