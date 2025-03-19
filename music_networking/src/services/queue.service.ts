import { QueueRepository } from "../repository/queue.repository";


export class QueueService {

    private queueRepository: QueueRepository;

    constructor(queueRepository: QueueRepository) {
        this.queueRepository = queueRepository;
    }

    async addSong(): Promise<void> {
        console.log("addSong");
    }

    async removeSong(): Promise<void> {
        console.log("removeSong");
    }
}