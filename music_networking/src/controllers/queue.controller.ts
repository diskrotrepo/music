
import { Request, Response } from "express";
import { QueueService } from "../services/queue.service";


export class QueueController {

    private queueService: QueueService;

    constructor(queueService: QueueService) {
        this.queueService = queueService;
    }

    getQueuedItem = async (req: Request, res: Response): Promise<void> => {
        const clientId = req.headers['client-id'] as string;
        const musicId = req.params.id;

        console.log("Getting queued item for client: ", clientId);
        let queuedItem = await this.queueService.getQueuedItem(musicId);

        res.status(200).json(queuedItem);
    }

    updateQueuedItem = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }

    queue = async (req: Request, res: Response): Promise<void> => {

        const clientId = req.headers['client-id'] as string;
        const body = req.body;

        console.log("Queueing item for client: ", clientId);
        console.log("Body: ", body);

        const queueItem = await this.queueService.queue(clientId, body);

        res.status(200).json({ id: queueItem });
    }

    getWorkQueue = async (req: Request, res: Response): Promise<void> => {

        const clientId = req.headers['client-id'] as string;
        const body = req.body;

        console.log("Getting work for client: ", clientId);

        const queueItem = await this.queueService.getWorkQueue(clientId);

        res.status(200).json({ id: queueItem });
    }
}

