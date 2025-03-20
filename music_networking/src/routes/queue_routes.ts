import { Router } from "express";
import { queueController } from "../controllers";


class QueueRoutes {
    router = Router();


    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.get("/queue", queueController.getQueuedItem);
        this.router.patch("/queue/:id", queueController.updateQueuedItem);
    }
}

export default new QueueRoutes().router;