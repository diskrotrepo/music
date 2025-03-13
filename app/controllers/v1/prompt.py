from flask_restx import Namespace, Resource, fields
from flask import request, jsonify
import os

from app.models import (
    Prompt,
    PromptyCategoryEnum,
)

from app.extensions import db

api = Namespace("prompt", description="Prompt related APIs")

category_values = [e.value for e in PromptyCategoryEnum]

prompt_definition = api.model(
    "Prompt",
    {
        "prompt": fields.String(
            required=True,
            description="Lyrics for your song",
            example="""Take the input, and produce an Simple LRC format file which takes into account time required to sing the previous line. 
            Time tags have the format [mm:ss.xx]lyric , where mm is minutes, ss is seconds, xx is hundredths of a second, 
            and lyric is the lyric to be played at that time. Do not provide any other information. I require just the file.

            Example output:

            [00:12.00]Line 1 lyrics
            [00:17.20]Line 2 lyrics""",
        ),
        "model": fields.String(
            required=True,
            description="Model that should be used by running this system prompt",
            example="llama-3.2-3b-instruct",
        ),
        "category": fields.String(
            required=True,
            description=f"Category of the prompt. Allowed values: {category_values}",
            example="LRC",
            enum=category_values,
        ),
        "is_default": fields.Boolean(
            required=True,
            description=f"Is this the default prompt for the given category",
            example=True,
        ),
    },
)

response = api.model(
    "PromptResponse",
    {
        "id": fields.String(
            description="Unique identifier for the prompt",
            example="b7e6a5d9-5f42-4a8b-9a38-47ef2e2a8df1",
        ),
    },
)


@api.route("")  
class PromptV1(Resource):

    @api.doc(description="Update system prompt for various LLMs", tags=["Prompt"])
    @api.expect(prompt_definition, True)
    @api.response(200, "Success", response)
    def post(self):
        try:
            # Get parameters from the request
            data = request.json or {}

            prompt = data.get("prompt")
            category = data.get("category")
            is_default = data.get("is_default")
            model = data.get("model")

            if category not in [e.value for e in PromptyCategoryEnum]:
                return {"error": "Invalid category"}, 400

            if is_default:
                db.session.query(Prompt).filter_by(category=category).update(
                    {"is_default": False}
                )

            new_prompt = Prompt(
                prompt=prompt,
                category=PromptyCategoryEnum(category),
                is_default=is_default,
                model=model,
            )

            db.session.add(new_prompt)
            db.session.commit()

            return {"id": new_prompt.id}, 201

        except Exception as e:
            db.session.rollback()
            return {"error": str(e)}, 500

@api.route("/<id>")  # No ID means fetching default
class PromptV1(Resource):

    
    @api.doc(description="Returns the specified system prompt", tags=["Prompt"])
    @api.response(200, "Success")
    @api.response(404, "Prompt not found")
    def get(self, id):
        """Retrieve the default prompt (LRC or POET as id) or a specific prompt by ID"""
        try:
            if id == "LRC" or id == "POET":
               
                query = db.session.query(Prompt).filter_by(is_default=True)
                if id == "LRC":
                    query = query.filter_by(category="LRC")
                else:
                    query = query.filter_by(category="POET")

                prompt = query.first()

            else:
                # Fetch prompt by ID
                prompt = db.session.query(Prompt).filter_by(id=id).first()

            if not prompt:
                if id == "LRC":
                    
                    return {
                        "id": 'LRC',
                        "prompt": get_default_lrc_prompt(),
                        "category": 'LRC',
                        "model": 'default',
                        "is_default": True,
                    }
                elif id == "POET":
                    return {
                        "id": 'POET',
                        "prompt": get_default_poet_prompt(),
                        "category": 'POET',
                        "model": 'default',
                        "is_default": True,
                    }
                else:    
                    return {"error": "Prompt not found"}, 404

            return {
                "id": prompt.id,
                "prompt": prompt.prompt,
                "category": prompt.category.value,
                "model": prompt.model,
                "is_default": prompt.is_default,
            }, 200

        except Exception as e:
            return jsonify({"error": str(e)}), 500
        


def get_default_poet_prompt():
    """Reads the poet prompt from app/config/poetDefault.txt."""
    prompt_path = os.path.join("app", "config", "poetDefault.txt")

    try:
        with open(prompt_path, "r", encoding="utf-8") as file:
            return file.read().strip()
    except FileNotFoundError:
        print(f"Error: Missing {prompt_path}")
        return None
    except Exception as e:
        print(f"Error reading {prompt_path}: {e}")
        return None    
    

def get_default_lrc_prompt():
    """Reads the lyric prompt from app/config/lrcDefault.txt."""
    prompt_path = os.path.join("app", "config", "lrcDefault.txt")

    try:
        with open(prompt_path, "r", encoding="utf-8") as file:
            return file.read().strip()
    except FileNotFoundError:
        print(f"Error: Missing {prompt_path}")
        return None
    except Exception as e:
        print(f"Error reading {prompt_path}: {e}")
        return None         