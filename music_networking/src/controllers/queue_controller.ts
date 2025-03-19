
import { Request, Response } from "express";
import { QueueService } from "../services/queue.service";


export class QueueController {

    private queueService: QueueService;

    constructor(queueService: QueueService) {
        this.queueService = queueService;
    }

    async getQueuedItem(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

    async updateQueuedItem(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }
}

