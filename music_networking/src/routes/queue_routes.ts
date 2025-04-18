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
        this.router.get("/next", authorizer(), queueController.getNextWorkItem);
        this.router.get("/current", authorizer(), queueController.getCurrentWorkItem);
        this.router.get("/:id", authorizer(), queueController.getQueuedItem);
        this.router.post("/:id/complete", authorizer(), queueController.completeQueueItem);
        this.router.post("/:id/error", authorizer(), queueController.errorQueueItem);
    }
}

export default new QueueRoutes().router;