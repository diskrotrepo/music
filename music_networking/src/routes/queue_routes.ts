import { Router } from "express";
import { QueueController } from "../controllers/queue_controller";


class QueueRoutes {
    router = Router();
    queueController = new QueueController();

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.get("/register", this.queueController.getQueuedItem);
        this.router.patch("/confirm", this.queueController.updateQueuedItem);
    }
}

export default new QueueRoutes().router;