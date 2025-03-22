import { Router } from "express";
import { queueController } from "../controllers";




class QueueRoutes {
    router = Router();
    queueController = queueController;

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        // #swagger.tags = ['Queue']
        // #swagger.summary = 'Performs an action against a song'
        // #swagger.description = 'This allows you to favorite, unfavorite, delete, and restore a song from the trash.'

        /* #swagger.responses[200] = {
                  description: 'Successfully update song',
          } */
        this.router.get("/next", this.queueController.getNextSong);


        // #swagger.tags = ['Queue']
        // #swagger.summary = 'Performs an action against a song'
        // #swagger.description = 'This allows you to favorite, unfavorite, delete, and restore a song from the trash.'

        /* #swagger.responses[200] = {
                description: 'Successfully update song',
        } */
        this.router.delete("", this.queueController.purgeQueue);

        // #swagger.tags = ['Queue']
        // #swagger.summary = 'Performs an action against a song'
        // #swagger.description = 'This allows you to favorite, unfavorite, delete, and restore a song from the trash.'

        /* #swagger.responses[200] = {
                description: 'Successfully update song',
        } */
        this.router.post("", this.queueController.addSong);

        // #swagger.tags = ['Queue']
        // #swagger.summary = 'Performs an action against a song'
        // #swagger.description = 'This allows you to favorite, unfavorite, delete, and restore a song from the trash.'

        /* #swagger.responses[200] = {
                description: 'Successfully update song',
        } */
        this.router.get("", this.queueController.getQueue);

        // #swagger.tags = ['Queue']
        // #swagger.summary = 'Performs an action against a song'
        // #swagger.description = 'This allows you to favorite, unfavorite, delete, and restore a song from the trash.'

        /* #swagger.responses[200] = {
                description: 'Successfully update song',
        } */
        this.router.delete("/:id", this.queueController.removeSong);
    }

}

export default new QueueRoutes().router;