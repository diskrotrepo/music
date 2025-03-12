export PYTHONPATH=$PYTHONPATH:$PWD
export FLASK_APP=app.app:create_app

conda activate diffrhythm
poetry init

if [ ! -d "migrations" ]; then
    mkdir app/instance
    touch app/instance/diskrot.db
    flask db init
fi

if [[ "$OSTYPE" =~ ^darwin ]]; then
     export PHONEMIZER_ESPEAK_LIBRARY=/opt/homebrew/Cellar/espeak-ng/1.52.0/lib/libespeak-ng.dylib
 fi

flask db migrate -m "Auto migration" || echo "No changes detected"
flask db upgrade

