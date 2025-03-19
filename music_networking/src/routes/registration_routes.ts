import { Router } from "express";
import { RegistrationController } from "../controllers/registration_controller";


class RegistrationRoutes {
    router = Router();
    registrationController = new RegistrationController();

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.post("/client", this.registrationController.registerClient);
        this.router.post("/activate/:code", this.registrationController.activateRegistration);
        this.router.get("/status/:clientID", this.registrationController.getRegistrationStatus);
        this.router.delete("/client/:clientID", this.registrationController.deleteRegistration);
    }
}

export default new RegistrationRoutes().router;