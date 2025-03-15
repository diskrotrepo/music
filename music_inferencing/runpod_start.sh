#!/bin/bash

cd /workspace/music/music_inferencing
source music/bin/activate
flask run --port=5001 --host=0.0.0.0