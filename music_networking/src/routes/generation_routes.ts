import { Router } from "express";
import { GenerationCotroller } from "../controllers/generation_controller";



class GenerationRoutes {
    router = Router();
    generationController = new GenerationCotroller();

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.post("/lyrics", this.generationController.generalLyrics);
        this.router.get("/music", this.generationController.generateMusic);
    }
}

export default new GenerationRoutes().router;