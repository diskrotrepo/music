#!/bin/sh

echo Running Music Queue
flask --app music_queue.app:create_app run