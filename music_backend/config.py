import os
import logging


class Config:
    DEBUG = False
    BASE_DIR = os.path.abspath(os.path.dirname(__file__))
    SQLALCHEMY_DATABASE_URI = (
        f"sqlite:///{os.path.join(BASE_DIR,'database', 'diskrot.db')})"
    )
    PORT = os.getenv("MUSIC_BACKEND_PORT", "5000")
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    HF_POET_MODEL = os.getenv("HF_POET_MODEL")


class DevelopmentConfig(Config):
    DEBUG = True


class ProductionConfig(Config):
    pass


available_configs = dict(development=DevelopmentConfig, production=ProductionConfig)
selected_config = os.getenv("FLASK_ENV", "production")
config = available_configs.get(selected_config, "production")
