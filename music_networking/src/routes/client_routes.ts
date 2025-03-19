import { Router } from "express";
import { ClientController } from "../controllers/client_controller";
import { clientService } from "../services";



class ClientRoutes {
    router = Router();
    clientController = new ClientController(clientService);

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.post("", this.clientController.updateSettings);
        this.router.get("", this.clientController.getSettings);
    }
}

export default new ClientRoutes().router;