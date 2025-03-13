from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
import logging
from celery import Celery

import transformers
import torch
import os

lrc_pipeline = None
poet_pipeline = None

print(os.getenv("LLM_SOURCE"))

if os.getenv("LLM_SOURCE") == "huggingface":
    if lrc_pipeline is None:
        lrc_model_id = os.getenv("HF_LRC_MODEL")
        lrc_pipeline = transformers.pipeline(
            "text-generation",
            model=lrc_model_id,
            model_kwargs={"torch_dtype": torch.bfloat16},
            device_map="auto",
        )
        print(f"LRC Model {lrc_model_id} loaded successfully!")

    if poet_pipeline is None:
        poet_model_id = os.getenv("HF_POET_MODEL")
        poet_pipeline = transformers.pipeline(
            "text-generation",
            model=poet_model_id,
            model_kwargs={"torch_dtype": torch.bfloat16},
            device_map="auto",
        )
        print(f"Poet Model {poet_model_id} loaded successfully!")


db = SQLAlchemy()
migrate = Migrate()
celery = Celery()

logging.basicConfig()
logging.getLogger("sqlalchemy.engine").setLevel(logging.INFO)


def register_extensions(app, worker=False):
    
    db.init_app(app)
    migrate.init_app(app, db)

    # load celery config
    celery.config_from_object(app.config)

    logging.info(f"Pipeline source -> {os.getenv("LLM_SOURCE")}")
    
    if not worker:
        from app.models import (
            Music,
            Prompt,
        )

        pass

def register_piplines():
    global lrc_pipeline, poet_pipeline 
    
    if lrc_pipeline is None:
        lrc_model_id = os.getenv("HF_LRC_MODEL")
        lrc_pipeline = transformers.pipeline(
            "text-generation",
            model=lrc_model_id,
            model_kwargs={"torch_dtype": torch.bfloat16},
            device_map="auto",
        )
        print(f"LRC Model {lrc_model_id} loaded successfully!")

    if poet_pipeline is None:
        poet_model_id = os.getenv("HF_POET_MODEL")
        poet_pipeline = transformers.pipeline(
            "text-generation",
            model=poet_model_id,
            model_kwargs={"torch_dtype": torch.bfloat16},
            device_map="auto",
        )
        print(f"Poet Model {poet_model_id} loaded successfully!")