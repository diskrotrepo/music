
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

    completeQueueItem = async (req: Request, res: Response): Promise<void> => {

        const clientId = req.headers['client-id'] as string;
        const musicId = req.params.id;
        await this.queueService.completeWork(musicId);

        res.status(200).json({ success: true });
    }

    errorQueueItem = async (req: Request, res: Response): Promise<void> => {

        const clientId = req.headers['client-id'] as string;
        const musicId = req.params.id;
        await this.queueService.errorWork(musicId);

        res.status(200).json({ success: true });
    }

    queue = async (req: Request, res: Response): Promise<void> => {

        const clientId = req.headers['client-id'] as string;
        const body = req.body;

        console.log("Queueing item for client: ", clientId);
        console.log("Body: ", body);

        try {
            const queueItem = await this.queueService.queue(clientId, body);
            res.status(200).json({ id: queueItem });
        } catch (e) {
            console.error("Error queueing item: ", e);
            res.status(400).json({ error: e });
        }
    }

    getWorkQueue = async (req: Request, res: Response): Promise<void> => {

        const clientId = req.headers['client-id'] as string;
        const body = req.body;

        console.log("Total work for client: ", clientId);

        const queueItem = await this.queueService.getWorkQueue(clientId);

        res.status(200).json({ queue: queueItem });
    }

    getNextWorkItem = async (req: Request, res: Response): Promise<void> => {

        const clientId = req.headers['client-id'] as string;


        console.log("Getting work for client: ", clientId);

        const queueItem = await this.queueService.getNextWorkItem(clientId);

        if (!queueItem) {
            console.log("No next work item found for client: ", clientId);
            res.status(404).json({ error: "No next work item found" });
            return;
        }

        console.log("Next work item found: ", queueItem);

        res.status(200).json({ queue: queueItem });
    }
}

