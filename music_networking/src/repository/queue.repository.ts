import { BaseRepository } from "./repository";


export class QueueRepository extends BaseRepository<Queue> {
    constructor(tableName: string) {
        super(tableName);
    }

    async enQueue(requestingClientId: string, destinationClientId: string, data: any): Promise<void> {

        await super.persist({
            pkey: destinationClientId,
            skey: `queue#${requestingClientId}`,
            data: data
        });
    }
}


export interface Queue {
    id: string
    client_id: string
    created_at: string
    updated_at: string
}