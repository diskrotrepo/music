import { Request, Response } from 'express';

interface MusicGenerationRequest {
    title: string
    lyrics: string
    duration: number
    steps: number
    cfg_strength: number
    chunked: boolean
    tags: string
    negative_tags: string
}

export class MusicController {

    public generate(req: Request, res: Response): void {
        const { id } = req.params;

        const data = { id, status: 'Active' };

        res.json(data);
    }

}