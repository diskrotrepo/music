import { Queue } from "../models/queue.model";
import { BaseRepository } from "./repository";


export class QueueRepository extends BaseRepository<Queue> {
    constructor(tableName: string) {
        super(tableName);
    }

    async enQueue(requestingClientId: string, destinationClientId: string, data: any): Promise<void> {

        await super.persist({
            pkey: destinationClientId,
            skey: `queue#${Date.now()}`,
            status: 'NEW',
            data: data,
            client_id: data.client_id,
            music_id: data.music_id
        });
    }

    async getByMusicId(queueId: string): Promise<Queue | null> {

        const results = await super.getByGSI('music_id-index', "music_id", queueId);

        if (results === null) {
            return null;
        }

        if (results.length !== 1) {
            throw new Error("Expected 1 result, got " + results.length);
        }

        return results[0];
    }
}


