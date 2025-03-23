import { BaseRepository } from "./repository";

export class ConnectionRepository extends BaseRepository<Connection> {
    constructor(tableName: string) {
        super(tableName);
    }

    async delete(clientId: string, connectedToClientId: string): Promise<void> {
        await super.deleteByPkeyAndSkey(clientId, `connection#${connectedToClientId}`);
    }



    async createConnection(clientId: string, connectedToClientId: string, invitationCode: string): Promise<void> {
        await super.persist({
            pkey: clientId,
            skey: `connection#${connectedToClientId}`,
            connected_to_client: connectedToClientId,
            invitation_code: invitationCode
        });
    }
}

export interface Connection {
    client_id: string
    connected_to_client: string
    invitationCode: string
    created_at: string
    updated_at: string
}