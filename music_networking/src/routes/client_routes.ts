import { Router } from "express";
import { clientController } from "../controllers";



class ClientRoutes {
    router = Router();

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.post("", clientController.updateSettings);
        this.router.get("", clientController.getSettings);
        this.router.get("/:id", clientController.getClient);
        this.router.delete("/:id", clientController.deleteClient);
    }
}

export default new ClientRoutes().router;