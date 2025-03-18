import { Router } from "express";
import { RegistrationCntroller } from "../controllers/registration_controller";


class RegistrationRoutes {
    router = Router();
    homeController = new RegistrationCntroller();

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.post("/register", this.homeController.register);
        this.router.get("/confirm", this.homeController.register);
    }
}

export default new RegistrationRoutes().router;