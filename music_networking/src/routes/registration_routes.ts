import { Router } from "express";
import { registrationController } from "../controllers";


class RegistrationRoutes {
    router = Router();

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.post("/client", registrationController.registerClient);
        this.router.post("/activate/:code", registrationController.activateRegistration);
        this.router.get("/status/:clientID", registrationController.getRegistrationStatus);
        this.router.delete("/client", registrationController.deleteRegistration);
    }
}

export default new RegistrationRoutes().router;