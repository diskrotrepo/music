#!/bin/sh

echo Running Music Backend
flask --app music_backend.app:create_app run