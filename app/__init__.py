from flask import Flask


from app.apiv1 import blueprint as api1


def create_app():
    app = Flask(__name__)

    # Load configuration
    app.config.from_object("app.config.Config")

    app.register_blueprint(api1)

    return app
