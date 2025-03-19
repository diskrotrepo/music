import { Router } from "express";
import { ClientController } from "../controllers/client_controller";



class ClientRoutes {
    router = Router();
    clientController = new ClientController();

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.post("/settings", this.clientController.updateSettings);
        this.router.get("/settings", this.clientController.getSettings);
    }
}

export default new ClientRoutes().router;