import { Request, Response } from "express";


export class GenerationCotroller {
    async generateMusic(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

    async generalLyrics(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }
}

