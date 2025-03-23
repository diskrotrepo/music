import { ConnectionRepository } from "../repository/connection.repository";
import { QueueRepository } from "../repository/queue.repository";


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

    async queue(requestingClientId: string, data: any): Promise<string> {
        //   let clientConnections: Array<Client> = await this.connectionRepository.getByPkey(requestingClientId) as Array<Client>;

        //   this.queueRepository.enQueue(requestingClientId, null, data);
        return "queue";
    }
}