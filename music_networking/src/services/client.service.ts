import { Client, ClientRepository } from "../repository/client.repository";
import { v4 as uuid } from "uuid";
import * as crypto from 'crypto';

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

    async registerClient(email: string, nickanme: string): Promise<Client> {

        let client: Client = {
            id: uuid(),
            email: email,
            nickname: nickanme,
            sharedSecret: crypto.randomBytes(16).toString('hex')
        }



        await this.clientRepository.create(client);
        return client;
    }

    getClient = async (id: string): Promise<Client | null> => {


        return await this.clientRepository.getById(id);
    }
}


