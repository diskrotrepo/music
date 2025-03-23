import { Router } from "express";
import { connectionController } from "../controllers";
import { authorizer } from "../authorization";



class ConnectionRoutes {
    router = Router();


    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.delete("/:id", authorizer(), connectionController.deleteConnection);
        this.router.get("", authorizer(), connectionController.getConnections);
    }
}

export default new ConnectionRoutes().router;