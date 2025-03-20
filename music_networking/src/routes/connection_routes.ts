import { Router } from "express";
import { connectionController } from "../controllers";



class ConnectionRoutes {
    router = Router();


    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.delete("/:id", connectionController.deleteConnection);
        this.router.get("", connectionController.getConnections);
    }
}

export default new ConnectionRoutes().router;