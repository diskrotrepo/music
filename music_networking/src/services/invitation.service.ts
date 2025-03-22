import { Invitation } from "../models/invitation.model";
import { InvitationRepository } from "../repository/invitation.repository";



export class InvitationService {
    private invitationRepository: InvitationRepository;

    constructor(invitationRepository: InvitationRepository) {
        this.invitationRepository = invitationRepository;
    }

    async createInvitation(clientId: string): Promise<string> {
        let code = Math.random().toString(36).substring(2, 15);
        await this.invitationRepository.createInvitation(code, clientId);
        return code;
    }
    async acceptInvitation(code: string): Promise<void> {
        return await this.invitationRepository.acceptInvitation(code);
    }
    async getInvitations(clientId: string): Promise<Array<Invitation>> {
        return await this.invitationRepository.getInvitations(clientId);
    }
    async rejectInvitation(code: string): Promise<void> {
        await this.invitationRepository.delete(code);
    }

}