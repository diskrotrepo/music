import { Request, Response } from 'express';
import configuration from '../../../config/configuration.json'
import { db } from '../database';
import DiskrotNetwork from '../network';
import { BaseController } from './base.controller';

export class SettingsController extends BaseController {




    constructor() {
        super();
    }

    async register(req: Request, res: Response): Promise<void> {

        const data = req.body || {};


        let fullUrl = configuration.diskrot.secure == true ? "https://" : "http://";
        fullUrl += configuration.diskrot.hostname + ":" + configuration.diskrot.port;
        fullUrl += configuration.diskrot.api + "/registration/client";

        const response = await fetch(
            fullUrl,
            {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            }
        );

        const ClientRegistrationResponse = await response.json() as ClientRegistrationResponse;

        const query = `
        INSERT INTO client (id, nickname, shared_secret)
        VALUES (?, ?, ?)
        `;

        db.prepare(query).run([
            ClientRegistrationResponse.client.id,
            ClientRegistrationResponse.client.nickname,
            ClientRegistrationResponse.client.sharedSecret
        ]);

        res.json({ "id": ClientRegistrationResponse.client.id });

    }

    async getClient(req: Request, res: Response): Promise<void> {

        const query = `SELECT nickname FROM client`;
        const result = db.prepare(query).get() as { nickname: string };

        if (!result) {
            res.status(404).json({ "error": "Client not found" });
            return;
        }
        res.json({ "nickname": result.nickname });


    }

    async disableClient(req: Request, res: Response): Promise<void> {
        const response = await fetch(
            `${configuration.diskrot}/registration/client`,
            {
                method: 'DELETE',
                headers: { 'Content-Type': 'application/json' }
            }
        ).then((response) => {
            const query = `DELETE FROM client`;
            db.prepare(query).run();

            res.json({ "success": true });
        });
    }

    async getInferenceServer(req: Request, res: Response): Promise<void> {
        const query = `SELECT * FROM settings WHERE key in ('inference_hostname', 'inference_port', 'inference_queue_size')`;
        const result = db.prepare(query).all() as { key: string, value: string }[];

        res.json({
            "hostname": result.find((r) => r.key === 'inference_hostname')?.value,
            "port": Number.parseInt(result.find((r) => r.key === 'inference_port')?.value).toFixed(0),
            "maxQueueSize": Number.parseInt(result.find((r) => r.key === 'inference_queue_size')?.value).toFixed(0)
        });
    }

    async setInferenceServer(req: Request, res: Response): Promise<void> {
        const data = req.body || {};

        const { hostname, port, max_queue_size } = data;
        db.prepare(`UPDATE settings SET value = ? WHERE key = 'inference_hostname'`).run(hostname);
        db.prepare(`UPDATE settings SET value = ? WHERE key = 'inference_port'`).run(port);
        db.prepare(`UPDATE settings SET value = ? WHERE key = 'inference_queue_size'`).run(max_queue_size);

        res.json({ "sucess": true });
    }

    public updatePrompt(req: Request, res: Response): void {
        const prompt: Prompt = req.body as Prompt;
        const query = `
        UPDATE prompt SET prompt = ?
        WHERE category = ?    
        `;

        db.prepare(query).run([
            prompt.prompt,
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


interface ClientRegistrationResponse {
    client: {
        id: string;
        nickname: string;
        sharedSecret: string;
    }
}

export interface Prompt {
    prompt: string
    model: string
    category: string
    is_default: boolean
}