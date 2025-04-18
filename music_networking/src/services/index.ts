import { clientRepository, connectionRepository, generationRepository, invitationRepository, queueRepository } from "../repository";
import { ClientService } from "./client.service";
import { ConnectionService } from "./connection.service";
import { EmailService } from "./email.service";
import { GenerationService } from "./generation.service";
import { InvitationService } from "./invitation.service";
import { QueueService } from "./queue.service";
import { RegistrationService } from "./registration.service";
import { ClientRepository } from "../repository/client.repository";

export const clientService = new ClientService(clientRepository);
export const connectionService = new ConnectionService(connectionRepository, invitationRepository, clientRepository);
export const generationService = new GenerationService(generationRepository);
export const invitationService = new InvitationService(invitationRepository, connectionRepository, clientRepository);
export const queueService = new QueueService(queueRepository, connectionRepository);
export const registrationService = new RegistrationService(clientRepository);
export const emailService = new EmailService();