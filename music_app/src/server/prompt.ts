import { Request, Response } from 'express';


interface Prompt {
    prompt: string
    model: string
    category: string
    is_default: boolean
}

export class PromptController {

    public updatePrompt(req: Request, res: Response): void {
        const { id } = req.params;

        const data = { success: true };

        res.json(data);
    }

    public getPrompt(req: Request, res: Response): void {
        const { id } = req.params;

        const data = {
            "prompt": "Take the input, and produce an Simple LRC format file which takes into account time required to sing the previous line. \n            Time tags have the format [mm:ss.xx]lyric , where mm is minutes, ss is seconds, xx is hundredths of a second, \n            and lyric is the lyric to be played at that time. Do not provide any other information. I require just the file.\n\n            Example output:\n\n            [00:12.00]Line 1 lyrics\n            [00:17.20]Line 2 lyrics",
            "model": "llama-3.2-3b-instruct",
            "category": "LRC",
            "is_default": true
        }

        res.json(data);
    }

}