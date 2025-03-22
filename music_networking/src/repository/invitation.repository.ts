import { Invitation } from "../models/invitation.model";
import { BaseRepository } from "./repository";


export class InvitationRepository extends BaseRepository<Invitation> {

    constructor(tableName: string) {
        super(tableName);
    }

    async delete(code: string) {
        throw new Error("Method not implemented.");
    }
    async getInvitations(clientId: string): Promise<Array<Invitation>> {
        throw new Error("Method not implemented.");
    }

    async acceptInvitation(invitation: any): Promise<void> {
        throw new Error("Method not implemented.");
    }
    async createInvitation(code: string, clientId: string) {
        throw new Error("Method not implemented.");
    }

}