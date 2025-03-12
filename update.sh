export PYTHONPATH=$PYTHONPATH:$PWD
export FLASK_APP=app.app:create_app

conda activate diffrhythm
pip install -r requirements.txt

if [ ! -d "migrations" ]; then
    mkdir app/instance
    touch app/instance/diskrot.db
    flask db init
fi

flask db migrate -m "Auto migration" || echo "No changes detected"
flask db upgrade

