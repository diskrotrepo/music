import { Router } from "express";
import { queueController } from "../controllers";
import { authorizer } from "../authorization";


class QueueRoutes {
    router = Router();


    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.post("", authorizer(), queueController.queue);
        this.router.get("", authorizer(), queueController.getWorkQueue);
        this.router.get("/:id", authorizer(), queueController.getQueuedItem);
        this.router.patch("/:id", authorizer(), queueController.updateQueuedItem);
    }
}

export default new QueueRoutes().router;