import { invitationRepository } from "../repository";
import { ConnectionRepository } from "../repository/connection.repository";
import { InvitationRepository } from "../repository/invitation.repository";


export class ConnectionService {

    private connectionRepository: ConnectionRepository;
    private invitationRepository: InvitationRepository;

    constructor(connectionRepository: ConnectionRepository, invitationRepository: InvitationRepository) {
        this.connectionRepository = connectionRepository;
        this.invitationRepository = invitationRepository;
    }

    async getConnections(clientId: string) {
        //  return await this.connectionRepository.getConnections(clientId);
    }

    async deleteConnection(clientId: string, connectionId: string) {
        await this.connectionRepository.delete(clientId, connectionId);

    }
}