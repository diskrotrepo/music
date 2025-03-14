from flask import Flask
from flask_cors import CORS
from music_queue.config import config
from music_queue.extensions import register_extensions
from music_queue.apiv1 import blueprint as api1
import time
from music_queue.extensions import db
from music_shared.lrc import get_default_lrc_prompt
from music_shared.models import Music, MusicProcessingEnum, Prompt
from diffrhythm.infer import generate


def create_app():
    app = Flask(
        __name__,
    )
    CORS(app, resources={r"/api/*": {"origins": "http://localhost:5173"}})

    app.config.from_object(config)
    app.register_blueprint(api1)

    register_extensions(app)

    return app


def poll_inference_queue():
    app = create_app()
    with app.app_context():
        query = db.session.query(Music).filter_by(
            processing_status=MusicProcessingEnum.NEW
        )
        songs = query.all()
        for song in songs:
            song.status = MusicProcessingEnum.IN_PROGRESS
            db.session.commit()
            print(f"Processing song {song.id}")

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
            print(f"Completed song {song.id}")
