import { clientService, connectionService, invitationService, queueService, registrationService } from "../services";
import { ClientController } from "./client.controller";
import { ConnectionController } from "./connection.controller";
import { InvitationController } from "./invitation.controller";
import { QueueController } from "./queue.controller";
import { RegistrationController } from "./registration.controller";


export const clientController = new ClientController(clientService);
export const connectionController = new ConnectionController(connectionService);
export const invitationController = new InvitationController(invitationService);
export const queueController = new QueueController(queueService);
export const registrationController = new RegistrationController(registrationService);