export PYTHONPATH=$PYTHONPATH:/home/alex/DiffRhythm
export CUDA_VISIBLE_DEVICES=0
export OPENAI_API_KEY=lm-studio

python -m tools.embedding_database.test_db