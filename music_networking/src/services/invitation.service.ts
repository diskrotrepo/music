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
    async acceptInvitation(clientId: string, code: string): Promise<{ nickname: string, client_id: string } | null> {
        const invitation: Array<Invitation> = await this.invitationRepository.getByPkey(code) as Array<Invitation>;

        if (!invitation || invitation.length !== 1) {
            console.error("Invitation not found");
            return null;
        }

        if (invitation[0].client_id === clientId) {
            console.error("Cannot accept your own invitation");
            return null;
        }

        if (invitation[0].accepted_client_id) {
            console.error("Invitation already accepted");
            return null;
        }

        await this.connectionRepository.createConnection(clientId, invitation[0].client_id, code);

        invitation[0].accepted_client_id = clientId;
        await this.invitationRepository.updateInvitation(invitation[0]);

        let connectedClient: Array<Client> = await this.clientRepository.getByPkey(invitation[0].client_id) as Array<Client>;

        console.log(connectedClient);

        if (!connectedClient) {
            console.error("Connected client not found");
            return null;
        }

        return {
            nickname: connectedClient[0].nickname,

            // @ts-ignore
            client_id: connectedClient[0].pkey
        };

    }
    async getInvitations(clientId: string): Promise<Array<Invitation>> {
        return await this.invitationRepository.getInvitations(clientId);
    }
    async rejectInvitation(code: string): Promise<void> {
        await this.invitationRepository.delete(code);
    }

}