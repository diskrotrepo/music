import { Connection } from "../models/connection.model";
import { invitationRepository } from "../repository";
import { ClientRepository } from "../repository/client.repository";
import { ConnectionRepository } from "../repository/connection.repository";
import { InvitationRepository } from "../repository/invitation.repository";


export class ConnectionService {

    private connectionRepository: ConnectionRepository;
    private invitationRepository: InvitationRepository;
    private clientRepository: ClientRepository;

    constructor(connectionRepository: ConnectionRepository, invitationRepository: InvitationRepository, clientRepository: ClientRepository) {
        this.clientRepository = clientRepository;
        this.connectionRepository = connectionRepository;
        this.invitationRepository = invitationRepository;
    }

    async getConnections(clientId: string): Promise<Array<Connection>> {
        let connections = await this.connectionRepository.getConnections(clientId);

        if (connections === null) {
            console.log("No connections found");
            return [];
        }

        for (let i = 0; i < connections.length; i++) {
            let connection = connections[i];
            let client = await this.clientRepository.getById(connection.connected_to_client);
            if (client === null) {
                console.log("Client not found");
                continue;
            }
            connection.nickname = client.nickname;
        }

        console.log("Connections found: ", connections.length);
        console.log("Connections: ", connections);
        return connections;
    }

    async deleteConnection(clientId: string, connectionId: string) {
        await this.connectionRepository.delete(clientId, connectionId);

    }
}