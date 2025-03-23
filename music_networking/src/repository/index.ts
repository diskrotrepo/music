import { ClientRepository } from "./client.repository";
import { ConnectionRepository } from "./connection.repository";
import { GenerationRepository } from "./generation.repository";
import { InvitationRepository } from "./invitation.repository";
import { QueueRepository } from "./queue.repository";

export const clientRepository = new ClientRepository("client-table");
export const connectionRepository = new ConnectionRepository("connection-table");
export const generationRepository = new GenerationRepository("generation-table");
export const invitationRepository = new InvitationRepository("connection-table");
export const queueRepository = new QueueRepository("queue-table");
