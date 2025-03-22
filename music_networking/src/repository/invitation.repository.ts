import { Invitation } from "../models/invitation.model";
import { BaseRepository } from "./repository";


export class InvitationRepository extends BaseRepository<Invitation> {

    constructor(tableName: string) {
        super(tableName);
    }

    async delete(code: string) {

    }
    async getInvitations(clientId: string): Promise<Array<Invitation>> {

        return [];
    }

    async acceptInvitation(invitation: any): Promise<void> {

    }
    async createInvitation(code: string, clientId: string) {

    }

}