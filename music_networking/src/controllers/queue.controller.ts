
import { Request, Response } from "express";
import { QueueService } from "../services/queue.service";


export class QueueController {

    private queueService: QueueService;

    constructor(queueService: QueueService) {
        this.queueService = queueService;
    }

    getQueuedItem = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }

    updateQueuedItem = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }
}

