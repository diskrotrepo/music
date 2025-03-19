import { Router } from "express";
import { GenerationCotroller } from "../controllers/generation_controller";
import { generationService } from "../services";



class GenerationRoutes {
    router = Router();
    generationController = new GenerationCotroller(generationService);

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.post("/lyrics", this.generationController.generalLyrics);
        this.router.get("/music", this.generationController.generateMusic);
    }
}

export default new GenerationRoutes().router;