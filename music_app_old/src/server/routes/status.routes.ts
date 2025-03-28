import { Router } from "express";
import { statusController } from "../controllers";




class StatusRoutes {
    router = Router();
    statusController = statusController;

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        // #swagger.tags = ['Status']
        // #swagger.summary = 'Return inference status'
        // #swagger.description = 'This make a request against the inference server to determine if the song has finished process.'

        /* #swagger.responses[200] = {
                  description: 'Get song status.',
                  schema: { $ref: '#/definitions/SongStatus' }
          } */
        this.router.get("/:id", this.statusController.getStatus);
    }
}

export default new StatusRoutes().router;