import { Router } from "express";
import { ConnectionController } from "../controllers/connection_controller";



class ConnectionRoutes {
    router = Router();
    connectionController = new ConnectionController();

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.delete("/confirm", this.connectionController.deleteConnection);
        this.router.get("/confirm", this.connectionController.getConnections);
    }
}

export default new ConnectionRoutes().router;