
# !!WARNING EXTREMELY UNSTABLE WHILE UNDER RAPID DEVELOPMENT!!

## Music Inference

blah blahblaha 

## Installation

**Setup Music Queue**

From the terminal go to the `music_queue` directory.

**Note**: The first time run will be slow because it needs to download the models.

1. Create an virtual environment with conda: `conda create -n music_inferencing python=3.12`
2. Activate the environment: `conda activate music_inferencing`
3. Install requirements: `pip install -r requirements.txt`

**Mac / Linnux**:
4a. Copy the .env.example file: `cp .env.example .env`

**Windows**:
4b. Copy the .env.example file: `cp env.example.bat env.bat`

5. Update the hugging face token variable `HF_TOKEN`

**Mac / Linnux**:
6a. Source the .env: `source .env`
**Windows**:
6b. Run: `env.bat`

7. From the music_backend directory: `flask db init`
8. Create an empty database file: `touch ../music_database/diskrot.db`
9. Run database migration: `flask db migrate`
10. Run database upgrade: `flask db upgrade`
11. Run flask: `flask run --port=5001`

By default this will run at http://127.0.0.1:5001 with API documents available at http://127.0.0.1:5001/api/v1/docs

## Installation RunPod

1. Select your GPU
2. Select: Torch 2.4.0 and Ubuntu 22
3. Edit the template and expose port 5001
3. SSH to the Machine

```bash
apt-get update && apt-get upgrade -y
apt-get install espeak-ng unzip
cd /workspace
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
flask db migrate
flask db update
flask run --port=5001 --host=0.0.0.0
```

## S3 

You can write the output to S3. If you do this be sure to update the .env for these properties:

```
S3_ENABLED=true
S3_BUCKET_NAME=<YourBucketName>
```


Then update the follow permissions for your bucket.

**CORS**

```json
[
    {
        "AllowedHeaders": [
            "*"
        ],
        "AllowedMethods": [
            "GET",
            "HEAD"
        ],
        "AllowedOrigins": [
            "*"
        ],
        "ExposeHeaders": [],
        "MaxAgeSeconds": 3000
    }
]
```

**Bucket Policy**

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::<YourBucketName>/*"
        }
    ]
}
```


Finally create an IAM user with access to read and write data to an S3 bucket, and create credentials which you'll use when installing the AWS CLI tool.


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
cd /workspace/music/music_inferencing
source music/bin/activate
flask run --port=5001 --host=0.0.0.0
```


# Common Errors

**Troubleshooting Windows**

If you get this error:

```text
```

Run these commands:

```bash
pip uninstall torch torchvision torchaudio
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
```

**NumPy Errors**

If you get this error:

```text
A module that was compiled using NumPy 1.x cannot be run in
NumPy 2.1.3 as it may crash. To support both 1.x and 2.x
versions of NumPy, modules must be compiled with NumPy 2.0.
Some module may need to rebuild instead e.g. with 'pybind11>=2.12'.

If you are a user of the module, the easiest solution will be to
downgrade to 'numpy<2' or try to upgrade the affected module.
We expect that some modules will need time to support NumPy 2.
```

run: `pip install "numpy<2"`
