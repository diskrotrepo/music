import { Router } from "express";
import { settingController } from "../controllers";



class SettingsRoutes {
  router = Router();
  settingController = settingController;

  constructor() {
    this.intializeRoutes();
  }

  intializeRoutes() {
    // #swagger.tags = ['Network']
    // #swagger.summary = 'Returns a list of songs'
    // #swagger.description = 'This will return a list of all songs'

    /* #swagger.responses[200] = {
              description: 'Get a list of your songs.',
              schema: { $ref: '#/definitions/GetLibraryResponse' }
      } */
    this.router.post("/register", this.settingController.register);


    // #swagger.tags = ['Prompt']
    // #swagger.summary = 'Returns details on a prompt'
    // #swagger.description = 'This will return a prompt based on the id. If you pass LRC or POET it will return the system default prompt'

    /* #swagger.responses[200] = {
                description: 'Get a specific prompt.',
                schema: { $ref: '#/definitions/Prompt' }
        } */
    this.router.get("/prompt/:id", this.settingController.getPrompt);
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
    this.router.post("/prompt", this.settingController.updatePrompt);


    this.router.post("/inference_server", this.settingController.setInferenceServer);


    this.router.get("/client", this.settingController.getClient);

    this.router.get("/inference_server", this.settingController.getInferenceServer);

    this.router.delete("/register", this.settingController.disableClient);
  }
}

export default new SettingsRoutes().router;