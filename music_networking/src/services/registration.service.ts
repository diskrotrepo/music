import { ClientRepository } from "../repository/client.repository";
import { v4 as uuid } from "uuid";
import * as crypto from 'crypto';
import { Client } from "../models/client.model";


export class RegistrationService {

    private clientRepository: ClientRepository;

    constructor(clientRepository: ClientRepository) {
        this.clientRepository = clientRepository;
    }

    async registerClient(nickname: string): Promise<Client> {

        let client: Client = {
            id: uuid(),
            nickname: nickname,
            sharedSecret: crypto.randomBytes(16).toString('hex')
        }

        await this.clientRepository.create(client);
        return client;
    }
}