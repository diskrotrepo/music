import { Router } from "express";




class GenerationRoutes {
    router = Router();


    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        //  this.router.post("/lyrics", generationController.generalLyrics);
        //  this.router.get("/music", generationController.generateMusic);
    }
}

export default new GenerationRoutes().router;