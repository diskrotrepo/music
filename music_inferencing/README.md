
# !!WARNING EXTREMELY UNSTABLE WHILE UNDER RAPID DEVELOPMENT!!

## Music Inference

This server handles the longer running inference tasks such as lyric generation (POET), LRC generation, and the music generation.

## Installation

By default this will run at http://127.0.0.1:5001 with API documents available at http://127.0.0.1:5001/api/v1/docs

## Installation RunPod 

1. You'll want either Ubuntu 22.04 or Windows running a WSL image of Ubuntu 22.04

```bash

sudo apt-get update && apt-get upgrade -y
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.10
sudo unlink /usr/local/bin/python
sudo ln -s /usr/local/bin/python3.10 /usr/local/bin/python
sudo apt-get install espeak-ng unzip sqlite3 build-essential cmake g++ make pkg-config -y
git clone https://github.com/diskrotrepo/music.git
cd music/music_inferencing
python -m venv music
source music/bin/activate
pip install -r requirements.txt
cp .env.example .env
; Replace abc123 with your hugging face access token
sed -i 's/<yourToken>/abc123/g' .env
source .env
; Note this will download some of the models and complain about 
flask db init
flask db migrate
flask db upgrade
flask run --port=5001 --host=0.0.0.0
```

## S3 

**Note** This assumes you've already follow the README in `infra` to create the required resources.

You can write the output to S3. If you do this be sure to update the .env for these properties:

```
S3_ENABLED=true
S3_BUCKET_NAME=<YourBucketName>
```

Then install the AWS CLI tool. 

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
aws configure
```

## Running Post Install RunPod

1. SSH to machine

```bash
cd music/music_inferencing
source music/bin/activate
flask run --port=5001 --host=0.0.0.0
```