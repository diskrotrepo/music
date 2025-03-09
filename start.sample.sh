export PYTHONPATH=$PYTHONPATH:$PWD
export CUDA_VISIBLE_DEVICES=0
export OPENAI_API_KEY=lm-studio
export USE_LOCAL_LLM=true
export LLM_API=http://192.168.7.216:1234/v1
export MODEL=llama-3.2-3b-instruct

conda activate diffrhythm
pip install -r requirements.txt
python3 server/app.py