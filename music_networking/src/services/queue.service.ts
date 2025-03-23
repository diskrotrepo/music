import { Client } from "../models/client.model";
import { Connection } from "../models/connection.model";
import { ConnectionRepository } from "../repository/connection.repository";
import { QueueRepository } from "../repository/queue.repository";
import { v4 as uuid } from "uuid";

export class QueueService {

    private queueRepository: QueueRepository;
    private connectionRepository: ConnectionRepository;

    constructor(queueRepository: QueueRepository, connectionRepository: ConnectionRepository) {
        this.queueRepository = queueRepository;
        this.connectionRepository = connectionRepository;
    }

    async addSong(): Promise<void> {
        console.log("addSong");
    }

    async removeSong(): Promise<void> {
        console.log("removeSong");
    }

    async getQueuedItem(musicId: string): Promise<any> {
        const results = await this.queueRepository.getByMusicId(musicId);
        console.log(results);

        return results;

    }

    async queue(requestingClientId: string, data: any): Promise<string> {

        let clientConnections: Array<Connection> = await this.connectionRepository.getById(requestingClientId) as Array<Connection>;

        if (clientConnections.length === 0) {
            throw new Error("Client has no connections");
        }

        data.client_id = requestingClientId;
        data.music_id = uuid();

        let connection = clientConnections[0];
        this.queueRepository.enQueue(requestingClientId, connection.connected_to_client, data);
        return data.music_id;
    }
}