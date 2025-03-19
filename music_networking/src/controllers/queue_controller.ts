
import { Request, Response } from "express";


export class QueueController {

    async getQueuedItem(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

    async updateQueuedItem(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }
}

