export PYTHONPATH=$PYTHONPATH:$PWD
export CUDA_VISIBLE_DEVICES=0
export OPENAI_API_KEY=

conda activate diffrhythm
pip install -r requirements.txt
python3 server/app.py