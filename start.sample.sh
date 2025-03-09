export PYTHONPATH=$PYTHONPATH:$PWD
export CUDA_VISIBLE_DEVICES=0
export OPENAI_API_KEY=lm-studio #Or your OpenAI API Key
export USE_LOCAL_LLM=true # false if using OpenAI
export LLM_API=http://192.168.7.216:1234/v1 # ignored when using OpenAI
export MODEL=llama-3.2-3b-instruct # The model you want to use important for local or OpenAI

conda activate diffrhythm
pip install -r requirements.txt
python3 server/app.py