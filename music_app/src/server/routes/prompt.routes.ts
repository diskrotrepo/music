import { Router } from "express";
import { PromptController } from "../controllers/prompt.controller";



class PromptRoutes {
    router = Router();
    promptController = new PromptController();

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        // #swagger.tags = ['Prompt']
        // #swagger.summary = 'Returns details on a prompt'
        // #swagger.description = 'This will return a prompt based on the id. If you pass LRC or POET it will return the system default prompt'

        /* #swagger.responses[200] = {
                    description: 'Get a specific prompt.',
                    schema: { $ref: '#/definitions/Prompt' }
            } */
        this.router.get("/:id", this.promptController.getPrompt);
        // #swagger.tags = ['Prompt']
        // #swagger.summary = 'Updates a prompt'
        // #swagger.description = 'This allows you to update a prompt.'

        /*  #swagger.parameters['body'] = {
                  in: 'body',
                  description: 'Update a prompt.',
                  schema: { $ref: '#/definitions/Prompt' }
          } */


        /* #swagger.responses[200] = {
        description: 'Successfully updated a prompt',
      } */
        this.router.post("", this.promptController.updatePrompt);
    }
}

export default new PromptRoutes().router;