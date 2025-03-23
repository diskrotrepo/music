import { Application } from "express";
import RegistrationRoutes from "./registration_routes";
import GenerationRoutes from "./generation_routes";
import ClientRoutes from "./client_routes";
import ConnectionRoutes from "./connection_routes";
import QueueRoutes from "./queue_routes";
import InvitationRoutes from "./invitation_routes";

export default class Routes {
    constructor(app: Application) {
        app.use("/api/v1/registration", RegistrationRoutes);
        app.use("/api/v1/generation", GenerationRoutes);
        app.use("/api/v1/client", ClientRoutes);
        app.use("/api/v1/connections", ConnectionRoutes);
        app.use("/api/v1/queue", QueueRoutes);
        app.use("/api/v1/invitations", InvitationRoutes);

    }
}