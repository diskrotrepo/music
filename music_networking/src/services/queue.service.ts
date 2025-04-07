import { Client } from "../models/client.model";
import { Connection } from "../models/connection.model";
import { Queue } from "../models/queue.model";
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

    async completeWork(musicId: string): Promise<any> {
        const results = await this.queueRepository.getByMusicId(musicId);

        if (results === null) {
            throw new Error("No item found with music_id: " + musicId);
        }

        if (results.processing_status !== "IN-PROGRESS") {
            throw new Error("Item is not in progress");
        }

        results.processing_status = "COMPLETED";
        await this.queueRepository.persist(results);

        return results;
    }

    async getQueuedItem(musicId: string): Promise<any> {
        const results = await this.queueRepository.getByMusicId(musicId);
        return results;
    }

    async getWorkQueue(clientId: string): Promise<Array<Queue>> {
        const results = await this.queueRepository.getWorkForClient(clientId, 10);

        if (results === null || results.length === 0) {
            console.log("No items found for client: " + clientId);
            return [];
        }

        console.log(results);


        return results as Array<Queue>;
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

    async getNextWorkItem(clientId: string): Promise<Queue | null> {
        const results = await this.queueRepository.getNextWorkItem(clientId, 1);

        if (results === null || results.length === 0) {
            return null;
        }

        return results[0] as Queue;
    }
}