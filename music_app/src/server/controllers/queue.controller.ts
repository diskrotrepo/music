import { Request, Response } from 'express';
import { db } from '../database';
import configuration from '../../../config/configuration.json'
import DiskrotNetwork from '../network';
import { BaseController } from './base.controller';

export class QueueController extends BaseController {




    constructor() {
        super();
    }
    getNextSong = async (req: Request, res: Response): Promise<void> => {
        console.log("Getting next song");
        res.status(200).json({});
    }

    purgeQueue = async (req: Request, res: Response): Promise<void> => {
        console.log("Purging queue");
        res.status(200).json({});
    }

    addSong = async (req: Request, res: Response): Promise<void> => {
        console.log("Adding song to queue");
        res.status(200).json({});
    }

    removeSong = async (req: Request, res: Response): Promise<void> => {
        console.log("Removing song from queue");
        res.status(200).json({});
    }

    getQueue = async (req: Request, res: Response): Promise<void> => {
        console.log("Get queue");
        res.status(200).json({});
    }
}