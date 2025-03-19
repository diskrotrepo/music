import { Request, Response } from "express";
import { GenerationService } from "../services/generation.service";


export class GenerationCotroller {
    private generationService: GenerationService;

    constructor(generationService: GenerationService) {
        this.generationService = generationService;
    }

    async generateMusic(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

    async generalLyrics(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }
}

