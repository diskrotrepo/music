import { Request, Response } from 'express';
import { db } from '../database';


export interface Prompt {
    prompt: string
    model: string
    category: string
    is_default: boolean
}

export class PromptController {

    public updatePrompt(req: Request, res: Response): void {
        const prompt: Prompt = req.body as Prompt;
        const query = `
        UPDATE prompt SET prompt = ?, model = ?
        WHERE category = ?    
        `;

        db.prepare(query).run([
            prompt.prompt,
            prompt.model,
            prompt.category
        ]);

        const data = { success: true };

        res.json(data);
    }

    public getPrompt(req: Request, res: Response): void {
        const { id } = req.params;

        if (!id) {
            res.status(400).json({ error: "Missing id parameter" });
            return;
        }

        const query = `SELECT * FROM prompt WHERE category = ? AND is_default = 1`;
        const prompt = db.prepare(query).get(id) as Prompt | undefined;

        if (!prompt) {
            res.status(404).json({ error: `Prompt ${id} not found` });
            return;
        }

        res.json(prompt);
    }

}