import { Router } from "express";
import { musicController } from "../controllers";



class MusicRoutes {
    router = Router();
    musicController = musicController;

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        // #swagger.tags = ['Music']
        // #swagger.summary = 'Submits a request to generate music'
        // #swagger.description = 'This API will make a request to the inference server to generate music'

        /*  #swagger.parameters['body'] = {
                  in: 'body',
                  description: 'Submits a song for generation.',
                   schema: { $ref: '#/definitions/Song' }
          } */


        /* #swagger.responses[200] = {
                    description: 'Successfully submitted a song for generation',
                     schema: { $ref: '#/definitions/MusicGenerationResponse' }
            } */
        this.router.post("/generate", this.musicController.generate);
    }
}

export default new MusicRoutes().router;