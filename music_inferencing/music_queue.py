import uuid
from flask import Flask, request, jsonify
from flask_cors import CORS
from music_inferencing.config import config
from music_inferencing.extensions import register_extensions
from music_inferencing.apiv1 import blueprint as api1
import time
from music_inferencing.extensions import db
from music_shared.lrc import get_default_lrc_prompt
from music_shared.models import Music, Prompt
from diffrhythm.infer import generate
import threading
import time
import logging
import os
import signal
from music_inferencing.background_thread import (
    BackgroundThreadFactory,
    TASKS_QUEUE,
    BackgroundThreadType,
)

logging.basicConfig(level=logging.INFO, force=True)


def create_app():
    app = Flask(
        __name__,
    )
    CORS(app, resources={r"/api/*": {"origins": "*"}})

    app.config.from_object(config)
    app.register_blueprint(api1)

    register_extensions(app)

    @app.route("/task", methods=["POST"])
    def submit_task():
        task = request.json
        logging.info(f"Received task: {task}")

        generation_id = str(uuid.uuid4())

        new_music = Music(
            id=generation_id,
            filename=f"{generation_id}.wav",
            title=task.get("title"),
            lyrics=task.get("lyrics"),
            prompt=task.get("tags"),
            negative_prompt=task.get("negative_tags"),
            input_file=task.get("input"),
            duration=task.get("duration"),
            steps=task.get("steps"),
            cfg_strength=task.get("cfg_strength"),
            model="unknown",
        )

        db.session.add(new_music)
        db.session.commit()

        return jsonify({"id": generation_id})

    notification_thread = BackgroundThreadFactory.create(
        BackgroundThreadType.INFERENCE, app
    )

    # this condition is needed to prevent creating duplicated thread in Flask debug mode
    if (
        not (app.debug or os.environ.get("FLASK_ENV") == "development")
        or os.environ.get("WERKZEUG_RUN_MAIN") == "true"
    ):
        notification_thread.start()

        original_handler = signal.getsignal(signal.SIGINT)

        def sigint_handler(signum, frame):
            notification_thread.stop()

            # wait until thread is finished
            if notification_thread.is_alive():
                notification_thread.join()

            original_handler(signum, frame)

        try:
            signal.signal(signal.SIGINT, sigint_handler)
        except ValueError as e:
            logging.error(f"{e}. Continuing execution...")

    return app
