import { Request, Response } from 'express';
import { db } from '../database';
import configuration from '../../../config/configuration.json'
import { Prompt } from './settings.controller';
import DiskrotNetwork from '../network';
import { BaseController } from './base.controller';

export interface MusicGenerationRequest {
    title: string
    lyrics: string
    duration: number
    steps: number
    cfg_strength: number
    chunked: boolean
    tags: string
    negative_tags: string
}

export class MusicController extends BaseController {




    constructor() {
        super();
    }

    async generate(req: Request, res: Response): Promise<void> {
        // #swagger.tags = ['Music']
        const data = req.body || {};

        const endpoint = "/task";
        const submitTaskUrl = `${configuration.inference_server}/${endpoint}`;
        console.info(`Submitting task to ${submitTaskUrl}`);

        const promptQuery = `
        SELECT * FROM prompt 
        WHERE is_default = 1 AND category = ? 
        LIMIT 1
        `;

        const lrcPromptResult: Prompt | undefined = db.prepare(promptQuery).get("LRC") as Prompt;

        const response = await fetch(`${configuration.api}/lyrics/poet`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                lyrics: data.lyrics,
                duration: data.duration,
                steps: data.steps,
                title: data.title,
                cfg_strength: data.cfg_strength,
                tags: data.tags,
                lrc_prompt: lrcPromptResult.prompt,
                lrc_model: lrcPromptResult.model,
                negative_tags: data.negative_tags,
            })
        });

        /*
        if (!response.ok) {

            res.status(500).json({ error: "Failed to submit task" });
            return;
        }


        const submitTaskResponse: { id: string } = await response.json() as { id: string };
        */
        const submitTaskResponse: { id: string } = { id: "yup" }


        const newMusicQuery = `
        INSERT INTO music (
            id, filename, title, lyrics, tags, inference_server, lrc_prompt, 
            lrc_model, negative_tags, input_file, duration, steps, cfg_strength, model, dt_created
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
        `;
        db.prepare(newMusicQuery).run(
            submitTaskResponse.id,
            "not available",
            data.title,
            data.lyrics,
            data.tags,
            submitTaskUrl,
            lrcPromptResult.prompt,
            lrcPromptResult.model,
            data.negative_tags,
            data.input,
            data.duration,
            data.steps,
            data.cfg_strength,
            "unknown"
        );

        res.json({ id: submitTaskResponse.id });

    }
}