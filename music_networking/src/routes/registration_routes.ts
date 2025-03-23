import { Router } from "express";
import { registrationController } from "../controllers";
import { authorizer } from "../authorization";


class RegistrationRoutes {
    router = Router();

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.post("/client", registrationController.registerClient);
        this.router.post("/activate/:code", authorizer(), registrationController.activateRegistration);
        this.router.get("/status/:clientID", authorizer(), registrationController.getRegistrationStatus);
        this.router.delete("/client", authorizer(), registrationController.deleteRegistration);
    }
}

export default new RegistrationRoutes().router;