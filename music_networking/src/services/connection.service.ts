import { ConnectionRepository } from "../repository/connection.repository";


export class ConnectionService {

    private connectionRepository: ConnectionRepository;

    constructor(connectionRepository: ConnectionRepository) {
        this.connectionRepository = connectionRepository;
    }

    async connect(): Promise<void> {
        console.log("connect");
    }

    async disconnect(): Promise<void> {
        console.log("disconnect");
    }
}