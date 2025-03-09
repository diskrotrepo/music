from flask import Flask, request, jsonify, send_from_directory, abort
from infer import generate
import os


app = Flask(__name__)
GENERATED_DIR = "./output"


@app.route("/v1/generate/<id>", methods=["GET"])
def download(id):

    if not id:
        abort(400, description="Missing 'id' parameter")

    file_name = "{}.wav".format(id)

    try:
        # Return the file as an attachment
        return send_from_directory(GENERATED_DIR, file_name, as_attachment=True)
    except Exception as e:
        abort(404, description=f"File not found: {file_name}")


@app.route("/v1/generate", methods=["POST"])
def run_generate():
    try:
        # Get parameters from the request

        lyrics = request.json.get("lyrics")
        input_file = request.json.get("input")
        audio_length = request.json.get("duration")
        steps = request.json.get("steps")
        cfg_strength = request.json.get("cfg_strength")
        chunked = request.json.get("chunked")
        tags = request.json.get("tags")
        negative_tags = request.json.get("negative_tags")

        # Ensure all required parameters are provided
        if not all([lyrics, audio_length, steps, cfg_strength]):
            return jsonify({"error": "Missing required parameters"}), 400

        output_path = generate(
            lyrics,
            input_file,
            audio_length,
            steps,
            cfg_strength,
            chunked,
            tags,
            negative_tags,
        )

        # Return the output
        return jsonify({"output_path": output_path})

    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
