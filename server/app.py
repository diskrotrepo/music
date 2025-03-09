from flask import Flask, request, jsonify
import subprocess
import os

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


        # Ensure all required parameters are provided
        if not all([lyrics, input_file, audio_length, output_file, steps, cfg_strength]):
            return jsonify({"error": "Missing required parameters"}), 400

        # Construct the command
        command = [
            "python3", "infer/infer.py",
            "--lyrics", lyrics,
            "--input_file", input_file,
            "--audio-length", str(audio_length),
            "--repo_id", "ASLP-lab/DiffRhythm-base",
            "--output-file", output_file,
            "--steps", str(steps),
            "--cfg_strength",str(cfg_strength),
            "--chunked",str(chunked)
        ]

        # Run the inference process
        process = subprocess.run(command, capture_output=True, text=True)

        # Return the output
        return jsonify({
            "stdout": process.stdout,
            "stderr": process.stderr
        })

    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
