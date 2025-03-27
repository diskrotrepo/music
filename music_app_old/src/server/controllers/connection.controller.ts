import { Request, Response } from 'express';
import { db } from '../database';
import configuration from '../../../config/configuration.json'
import DiskrotNetwork from '../network';
import { v4 as uuid } from 'uuid'
import { BaseController } from './base.controller';

export class ConnectionController extends BaseController {

    constructor() {
        super();
    }

    getConnections = async (req: Request, res: Response): Promise<void> => {
        let connections = db.prepare("SELECT * FROM connections").all();
        res.status(200).json(connections);
    }

    deleteConnection = async (req: Request, res: Response): Promise<void> => {

        if (!req.params.id) {
            res.status(400).json({ error: "Invalid request" });
            return;
        }

        await this.diskrotNetwork.delete(`/connections/${req.params.id}`);

        db.prepare("DELETE FROM connections WHERE client_id = ?").run([req.params.id]);
        res.status(200).json({});
    }
}

