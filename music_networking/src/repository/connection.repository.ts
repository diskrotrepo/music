import { BaseRepository } from "./repository";

export class ConnectionRepository extends BaseRepository<Connection> {
    constructor(tableName: string) {
        super(tableName);
    }

}

export interface Connection {
    client_id: string
    connected_to_client: string
    created_at: string
    updated_at: string
}