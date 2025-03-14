
# !!WARNING EXTREMELY UNSTABLE WHILE UNDER RAPID DEVELOPMENT!!

## diskrot fork of DiffRhythm

This fork is focused on the specific needs for the diskrot community. The original repo is here: https://github.com/ASLP-lab/DiffRhythm and when it makes sense improves from that repo will be ported into this repo. 

## Installation

**Prerequisites**

1. Node
2. NPM
3. Python
4. Register with huggingface (https://huggingface.co/) and obtain an access token
5. Install python-dotenv

**Get the Code**

1. Clone the repo: `git clone https://github.com/diskrotrepo/music.git`

**Setup Music Backend**

From the terminal go to the `music_backend` directory.

**Note**: The first time run will be slow because it needs to download the models.

1. Create an virtual environment with conda: `conda create -n music_backend python=3.12`
2. Activate the environment: `conda activate music_backend`
3. Install requirements: `pip install -r requirements.txt`
4. Copy the .env.example file: `cp .env.example .env`
5. Update the hugging face token variable `HF_TOKEN`
6. Source the .env: `source .env`
7. From the music_backend directory: `flask db init`
8. Create an empty database file: `touch ../music_database/diskrot.db`
9. Run database migration: `flask db migrate`
10. Run database upgrade: `flask db upgrade`
11. Run flask: `flask run`

By default this will run at http://127.0.0.1:5000 with API documents available at http://127.0.0.1:5000/api/v1/docs

**Setup Music Queue**

From the terminal go to the `music_queue` directory.

**Note**: The first time run will be slow because it needs to download the models.

1. Create an virtual environment with conda: `conda create -n music_queue python=3.12`
2. Activate the environment: `conda activate music_queue`
3. Install requirements: `pip install -r requirements.txt`
4. Copy the .env.example file: `cp .env.example .env`
5. Update the hugging face token variable `HF_TOKEN`
6. Source the .env: `source .env`
7. Run flask: `flask run`

By default this will run at http://127.0.0.1:5001 with API documents available at http://127.0.0.1:5001/api/v1/docs


**Web App**

From the music_frontend

1. Run npm install: `npm install`
2. Start the server: `npm run dev`

# Database

The project is using SQLite which can access with the following command: `sqlite music_database/diskrot.db`

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

## License & Disclaimer

DiffRhythm (code and DiT weights) is released under the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0). This open-source license allows you to freely use, modify, and distribute the model, as long as you include the appropriate copyright notice and disclaimer.

We do not make any profit from this model. Our goal is to provide a high-quality base model for music generation, fostering innovation in AI music and contributing to the advancement of human creativity. We hope that DiffRhythm will serve as a foundation for further research and development in the field of AI-generated music.

DiffRhythm enables the creation of original music across diverse genres, supporting applications in artistic creation, education, and entertainment. While designed for positive use cases, potential risks include unintentional copyright infringement through stylistic similarities, inappropriate blending of cultural musical elements, and misuse for generating harmful content. To ensure responsible deployment, users must implement verification mechanisms to confirm musical originality, disclose AI involvement in generated works, and obtain permissions when adapting protected styles.

## Citation
```
@article{ning2025diffrhythm,
  title={{DiffRhythm}: Blazingly Fast and Embarrassingly Simple End-to-End Full-Length Song Generation with Latent Diffusion},
  author={Ziqian, Ning and Huakang, Chen and Yuepeng, Jiang and Chunbo, Hao and Guobin, Ma and Shuai, Wang and Jixun, Yao and Lei, Xie},
  journal={arXiv preprint arXiv:2503.01183},
  year={2025}
}
```
