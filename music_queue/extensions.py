from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
import logging

import transformers
import torch
import os

lrc_pipeline = None

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

db = SQLAlchemy()
migrate = Migrate()

logging.basicConfig()
logging.getLogger("sqlalchemy.engine").setLevel(logging.INFO)

def register_extensions(app, worker=False):
    
    db.init_app(app)
    migrate.init_app(app, db)

    logging.info(f"Pipeline source -> {os.getenv("LLM_SOURCE")}")
    
    
    from music_shared.models import (
        Music,
        Prompt,
    )
