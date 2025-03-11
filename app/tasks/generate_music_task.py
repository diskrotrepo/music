from celery import shared_task
from infer import generate
from app.extensions import celery
from celery.utils.log import get_task_logger
from celery.signals import task_postrun
from app.models import Music
from app.extensions import db


logger = get_task_logger(__name__)


@celery.task(name="inference task")
def generate_music_task(
    lyrics,
    input_file,
    duration,
    steps,
    cfg_strength,
    chunked,
    tags,
    lrcPrompt,
    negative_tags,
    use_embedding,
):

    generation_id = generate(
        lyrics,
        None,
        duration,
        steps,
        cfg_strength,
        chunked,
        tags,
        lrcPrompt,
        negative_tags,
        use_embedding,
    )

    new_music = Music(filename=generation_id)
    db.session.add(new_music)
    db.session.commit()
