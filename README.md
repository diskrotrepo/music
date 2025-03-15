
# !!WARNING EXTREMELY UNSTABLE WHILE UNDER RAPID DEVELOPMENT!!

## diskrot fork of DiffRhythm

This fork is focused on the specific needs for the diskrot community. The original repo is here: https://github.com/ASLP-lab/DiffRhythm and when it makes sense improves from that repo will be ported into this repo. Code for that repo has been modified and lives in `diffrhythm`

## Architecture

Now it's not fair to say that LRC and POET are their own models at this point. For now these can use whatever model you want, but eventually we'll want fine tuned models for this purpose.

![diagram showing project architecture](/assets/architecture.png)


## Installation

**Project Prerequisites**

1. Node
2. NPM
3. Python
4. Register with huggingface (https://huggingface.co/) and obtain an access token
5. Install python-dotenv

**Get the Code**

1. Clone the repo: `git clone https://github.com/diskrotrepo/music.git`

**Setup Infrastructure**

Follow the README within `infra`

**Setup Music Backend**

Follow the README within `music_backend`

**Setup Music Queue**

Follow the README within `music_inference`

**Web App**

Follow the README within `music_frontend`
