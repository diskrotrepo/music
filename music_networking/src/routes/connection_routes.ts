import { Router } from "express";
import { ConnectionController } from "../controllers/connection_controller";
import { connectionService } from "../services";



class ConnectionRoutes {
    router = Router();
    connectionController = new ConnectionController(connectionService);

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.delete("/:id", this.connectionController.deleteConnection);
        this.router.get("", this.connectionController.getConnections);
    }
}

export default new ConnectionRoutes().router;