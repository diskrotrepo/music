
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
11. Run flask: `flask run`

By default this will run at http://127.0.0.1:5001 with API documents available at http://127.0.0.1:5001/api/v1/docs

# Common Errors

**NumPy Errors on Mac**

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
