import { Invitation } from "../models/invitation.model";
import { BaseRepository } from "./repository";


export class InvitationRepository extends BaseRepository<Invitation> {

    constructor(tableName: string) {
        super(tableName);
    }

    async delete(code: string) {
        await super.deleteByPkeyAndSkey(code, "invitation#");
    }

    async getInvitations(clientId: string): Promise<Array<Invitation>> {

        return [];
    }

    async updateInvitation(invitation: Invitation): Promise<void> {
        await super.persist(invitation);
    }

    async acceptInvitation(invitation: any): Promise<void> {

    }
    async persistInvitation(code: string, clientId: string) {
        await super.persist({
            pkey: code,
            skey: `invitation#`,
            client_id: clientId
        });
    }



}