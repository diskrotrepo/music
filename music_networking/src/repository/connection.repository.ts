import { Connection } from "../models/connection.model";
import { BaseRepository } from "./repository";

export class ConnectionRepository extends BaseRepository<Connection> {

    constructor(tableName: string) {
        super(tableName);
    }

    async delete(clientId: string, connectedToClientId: string): Promise<void> {
        await super.deleteByPkeyAndSkey(clientId, `connection#${connectedToClientId}`);
    }

    async getConnections(clientId: string): Promise<Array<Connection>> {


        let data = await super.getByPkeyAndSkey(clientId, 'connection#');

        if (data === null) {
            return [];
        }

        return data as Array<Connection>;
    }

    async createConnection(clientId: string, connectedToClientId: string, invitationCode: string): Promise<void> {
        await super.persist({
            pkey: clientId,
            skey: `connection#${connectedToClientId}`,
            connected_to_client: connectedToClientId,
            invitation_code: invitationCode
        });
    }

    async getById(id: string): Promise<Array<Connection>> {

        let filter = new Map<string, string>([
            ["pkey", "client_id"],
            ["skey", ""]
        ]);

        let data = await super.getByPkey(id, filter);

        if (data === null) {
            return [];
        }

        return data as Array<Connection>;
    }
}

