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
        this.router.get("/queue", authorizer(), queueController.getQueuedItem);
        this.router.patch("/queue/:id", authorizer(), queueController.updateQueuedItem);
    }
}

export default new QueueRoutes().router;