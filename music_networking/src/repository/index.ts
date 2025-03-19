import { ClientRepository } from "./client.repository";
import { ConnectionRepository } from "./connection.repository";
import { GenerationRepository } from "./generation.repository";
import { InvitationRepository } from "./invitation.repository";
import { QueueRepository } from "./queue.repository";
import { RegistrationRepository } from "./registration.repository";



export const clientRepository = new ClientRepository();
export const connectionRepository = new ConnectionRepository();
export const generationRepository = new GenerationRepository();
export const invitationRepository = new InvitationRepository();
export const queueRepository = new QueueRepository();
export const registrationRepository = new RegistrationRepository();