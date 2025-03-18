import { Application } from "express";
import RegistrationRoutes from "./registration_routes";

export default class Routes {
    constructor(app: Application) {
        app.use("/registration", RegistrationRoutes);
    }
}