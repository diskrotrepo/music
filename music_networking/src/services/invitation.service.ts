import { Client } from "../models/client.model";
import { Invitation } from "../models/invitation.model";
import { ClientRepository } from "../repository/client.repository";
import { ConnectionRepository } from "../repository/connection.repository";
import { InvitationRepository } from "../repository/invitation.repository";



export class InvitationService {
    private invitationRepository: InvitationRepository;
    private connectionRepository: ConnectionRepository;
    private clientRepository: ClientRepository;

    constructor(invitationRepository: InvitationRepository, connectionRepository: ConnectionRepository, clientRepository: ClientRepository) {
        this.invitationRepository = invitationRepository;
        this.connectionRepository = connectionRepository;
        this.clientRepository = clientRepository;
    }

    async createInvitation(clientId: string): Promise<string> {
        let code = Math.random().toString(36).substring(2, 15);
        await this.invitationRepository.persistInvitation(code, clientId);
        return code;
    }
    async acceptInvitation(clientId: string, code: string): Promise<string | null> {
        const invitation: Invitation = await this.invitationRepository.getByPkey(code) as Invitation;

        if (!invitation) {
            console.error("Invitation not found");
            return null;
        }

        if (invitation.client_id === clientId) {
            console.error("Cannot accept your own invitation");
            return null;
        }

        if (invitation.accepted_client_id) {
            console.error("Invitation already accepted");
            return null;
        }

        await this.connectionRepository.createConnection(clientId, invitation.client_id);

        invitation.accepted_client_id = clientId;
        await this.invitationRepository.updateInvitation(invitation);

        let connectedClient = await this.clientRepository.getByPkey(invitation.client_id) as Client;


        return connectedClient.nickname;

    }
    async getInvitations(clientId: string): Promise<Array<Invitation>> {
        return await this.invitationRepository.getInvitations(clientId);
    }
    async rejectInvitation(code: string): Promise<void> {
        await this.invitationRepository.delete(code);
    }

}