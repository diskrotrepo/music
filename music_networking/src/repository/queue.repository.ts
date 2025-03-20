import { BaseRepository } from "./repository";


export class QueueRepository extends BaseRepository<Queue> {
    constructor(tableName: string) {
        super(tableName);
    }
}


export interface Queue {
    id: string
    client_id: string
    created_at: string
    updated_at: string
}