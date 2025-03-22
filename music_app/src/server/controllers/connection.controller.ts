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
        db.prepare("DELETE FROM connections WHERE id = ?").run([req.params.id]);
        res.status(200).json({});
    }
}

