import { BaseRepository } from "./repository";

export class ConnectionRepository extends BaseRepository<Connection> {
    constructor(tableName: string) {
        super(tableName);
    }

    async delete(clientId: string, connectedToClientId: string): Promise<void> {

    }

    async createConnection(clientId: string, connectedToClientId: string): Promise<void> {
        await super.persist({
            pkey: clientId,
            skey: `connection#${connectedToClientId}`,
            connected_to_client: connectedToClientId
        });
    }
}

export interface Connection {
    client_id: string
    connected_to_client: string
    created_at: string
    updated_at: string
}