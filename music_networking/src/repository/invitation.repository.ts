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
        const results = await super.getByGSI('client_id-index', "client_id", clientId);

        if (results === null || results.length === 0) {
            console.log("No invitations found for client ID: ", clientId);
            return [];
        }

        console.log("Results: ", results);

        return results as Array<Invitation>;
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