import { InvitationRepository } from "../repository/invitation.repository";



export class InvitationService {
    private invitationRepository: InvitationRepository;

    constructor(invitationRepository: InvitationRepository) {
        this.invitationRepository = invitationRepository;
    }
}