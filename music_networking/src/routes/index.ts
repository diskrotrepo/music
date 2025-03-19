import { Application } from "express";
import RegistrationRoutes from "./registration_routes";
import GenerationRoutes from "./generation_routes";
import ClientRoutes from "./client_routes";
import ConnectionRoutes from "./connection_routes";
import QueueRoutes from "./queue_routes";
import InvitationRoutes from "./invitation_routes";

export default class Routes {
    constructor(app: Application) {
        app.use("/registration", RegistrationRoutes);
        app.use("/generation", GenerationRoutes);
        app.use("/client", ClientRoutes);
        app.use("/connection", ConnectionRoutes);
        app.use("/queue", QueueRoutes);
        app.use("/invitation", InvitationRoutes);

    }
}