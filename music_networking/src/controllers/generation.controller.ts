import { Request, Response } from "express";
import { GenerationService } from "../services/generation.service";


export class GenerationCotroller {
    private generationService: GenerationService;

    constructor(generationService: GenerationService) {
        this.generationService = generationService;
    }

    generateMusic = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }

    generalLyrics = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }
}

