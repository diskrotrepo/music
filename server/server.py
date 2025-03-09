from flask import Flask, request, jsonify
import subprocess
import os

app = Flask(__name__)

@app.route("/infer", methods=["POST"])
def run_inference():
    try:
        # Get parameters from the request
        lrc_path = request.json.get("lrc_path")
        ref_audio_path = request.json.get("ref_audio_path")
        audio_length = request.json.get("audio_length")
        output_dir = request.json.get("output_dir")

        # Ensure all required parameters are provided
        if not all([lrc_path, ref_audio_path, audio_length, output_dir]):
            return jsonify({"error": "Missing required parameters"}), 400

        # Construct the command
        command = [
            "python3", "infer/infer.py",
            "--lrc-path", lrc_path,
            "--ref-audio-path", ref_audio_path,
            "--audio-length", str(audio_length),
            "--repo_id", "ASLP-lab/DiffRhythm-base",
            "--output-dir", output_dir
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
    app.run(host="0.0.0.0", port=8080, debug=True)
