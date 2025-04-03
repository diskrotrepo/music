import { Router } from "express";
import { statusController } from "../controllers";



class StatusRoutes {
    router = Router();

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.get("/health", statusController.health);

    }
}

export default new StatusRoutes().router;