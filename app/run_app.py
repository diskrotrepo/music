from flask import Flask
from .apiv1 import blueprint as api1


if __name__ == "__main__":
    app = Flask(__name__)
    app.register_blueprint(api1)
    app.run(debug=True, host="0.0.0.0", port=5000)
