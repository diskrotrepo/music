from flask import Flask, request, jsonify
from infer import generate


app = Flask(__name__)


@app.route("/v1/generate", methods=["POST"])
def run_inference():
    try:
        # Get parameters from the request

        lyrics = request.json.get("lyrics")
        input_file = request.json.get("input")
        audio_length = request.json.get("duration")
        output_file = request.json.get("output")
        steps = request.json.get("steps")
        cfg_strength = request.json.get("cfg_strength")
        chunked = request.json.get("chunked")
        tags = request.json.get("tags")

        # Ensure all required parameters are provided
        if not all([lyrics, audio_length, output_file, steps, cfg_strength]):
            return jsonify({"error": "Missing required parameters"}), 400

        generate(
            lyrics,
            input_file,
            audio_length,
            output_file,
            steps,
            cfg_strength,
            chunked,
            tags,
        )

        # Return the output
        return jsonify({"stdout": "hello"})

    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
