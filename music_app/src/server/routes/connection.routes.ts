
import { Router } from "express";
import { connectionConntroller } from "../controllers";



class ConnectionRoutes {
    router = Router();
    connectionConntroller = connectionConntroller;

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        // #swagger.tags = ['Connection']
        // #swagger.summary = 'Returns a list of songs'
        // #swagger.description = 'This will return a list of all songs'

        /* #swagger.responses[200] = {
                  description: 'Get a list of your songs.',
                  schema: { $ref: '#/definitions/GetLibraryResponse' }
          } */
        this.router.get("", this.connectionConntroller.getConnections);
        // #swagger.tags = ['Invitation']
        // #swagger.summary = 'Performs an action against a song'
        // #swagger.description = 'This allows you to favorite, unfavorite, delete, and restore a song from the trash.'

        /* #swagger.responses[200] = {
                  description: 'Successfully update song',
          } */

        this.router.delete("/:id", this.connectionConntroller.deleteConnection);
    }

}


export default new ConnectionRoutes().router;