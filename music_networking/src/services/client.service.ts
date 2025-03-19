import { ClientRepository } from "../repository/client.repository";


export class ClientService {

    private clientRepository: ClientRepository;

    constructor(clientRepository: ClientRepository) {
        this.clientRepository = clientRepository;
    }

    async updateSettings(): Promise<void> {
        console.log("updateSettings");
    }

    async getSettings(): Promise<void> {
        console.log("getSettings");
    }
}