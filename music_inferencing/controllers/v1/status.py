from flask_restx import Namespace, Resource, fields
from flask import request


api = Namespace("status", description="Status related APIs")


@api.route("/status")
@api.doc(
    description="Returns status of the API",
    tags=["Status"],
)
class StatusController(Resource):
    @api.response(200, "Success")
    def get(self):
        """Retrieve API status."""
        try:
            return {
                "status": "ok",
            }, 200
        except Exception as e:
            return {"error": str(e)}, 500
