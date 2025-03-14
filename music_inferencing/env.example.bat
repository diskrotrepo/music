SET PYTHONPATH=$PYTHONPATH
SET CUDA_VISIBLE_DEVICES=0

SET FLASK_ENV="development"
SET FLASK_APP="music_queue:create_app"
SET SECRET_KEY="change_me"
SET FLASK_DEBUG=1

:: local, huggingface, openai
SET LLM_SOURCE=huggingface

:: OpenAI

SET OPENAI_API_KEY=lm-studio

:: LM Studio or LM Studio compadible options

SET LLM_API=http://192.168.7.216:1234/v1
SET MODEL=llama-3.2-3b-instruct

:: Hugging Face models 

SET HF_TOKEN=<yourToken>
SET HF_LRC_MODEL=meta-llama/Llama-3.2-1B-Instruct
SET HF_POET_MODEL=meta-llama/Llama-3.2-1B-Instruct

:: Paths

SET MUSIC_BACKEND_URL="http://localhost"
SET MUSIC_QUEUE_URL="http://localhost"

SET MUSIC_BACKEND_PORT=5000
SET MUSIC_QUEUE_PORT=5001
