import { Router } from "express";
import { libraryController } from "../controllers";




class LibraryRoutes {
    router = Router();
    libraryController = libraryController;

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        // #swagger.tags = ['Library']
        // #swagger.summary = 'Returns a list of songs'
        // #swagger.description = 'This will return a list of all songs'

        /* #swagger.responses[200] = {
                  description: 'Get a list of your songs.',
                  schema: { $ref: '#/definitions/GetLibraryResponse' }
          } */
        this.router.get("", this.libraryController.getLibrary);
        // #swagger.tags = ['Library']
        // #swagger.summary = 'Performs an action against a song'
        // #swagger.description = 'This allows you to favorite, unfavorite, delete, and restore a song from the trash.'

        /* #swagger.responses[200] = {
                  description: 'Successfully update song',
          } */
        this.router.get("/song/:song/action/:acton", this.libraryController.performAction);
    }
}

export default new LibraryRoutes().router;