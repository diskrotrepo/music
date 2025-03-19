import { Router } from "express";
import { QueueController } from "../controllers/queue_controller";
import { queueService } from "../services";


class QueueRoutes {
    router = Router();
    queueController = new QueueController(queueService);

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.get("/queue", this.queueController.getQueuedItem);
        this.router.patch("/queue/:id", this.queueController.updateQueuedItem);
    }
}

export default new QueueRoutes().router;