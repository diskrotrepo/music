import { clientRepository, connectionRepository, generationRepository, invitationRepository, queueRepository } from "../repository";
import { ClientService } from "./client.service";
import { ConnectionService } from "./connection.service";
import { EmailService } from "./email.service";
import { GenerationService } from "./generation.service";
import { InvitationService } from "./invitation.service";
import { QueueService } from "./queue.service";
import { RegistrationService } from "./registration.service";


export const clientService = new ClientService(clientRepository);
export const connectionService = new ConnectionService(connectionRepository);
export const generationService = new GenerationService(generationRepository);
export const invitationService = new InvitationService(invitationRepository);
export const queueService = new QueueService(queueRepository);
export const registrationService = new RegistrationService(clientRepository);
export const emailService = new EmailService();