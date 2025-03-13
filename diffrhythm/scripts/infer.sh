#!/bin/bash

cd "$(dirname "$0")"
cd ../

export PYTHONPATH=$PYTHONPATH:$PWD
export CUDA_VISIBLE_DEVICES=0

# Assign variables from arguments
LRC_PATH=infer/example/eg_cn.lrc
AUDIO_PATH=input/$1
LENGTH=95
OUTPUT_DIR=output

# Check if all parameters are provided
if [ -z "$LRC_PATH" ] || [ -z "$AUDIO_PATH" ] || [ -z "$LENGTH" ] || [ -z "$OUTPUT_DIR" ]; then
    echo "Usage: $0 <lrc-path> <audio-path> <length> <output-dir>"
    exit 1
fi

python3 infer/infer.py \
    --lrc-path "$LRC_PATH" \
    --ref-audio-path "$AUDIO_PATH" \
    --audio-length "$LENGTH" \
    --repo_id ASLP-lab/DiffRhythm-base \
    --output-dir "$OUTPUT_DIR"
