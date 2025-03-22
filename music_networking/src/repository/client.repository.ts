import { DeleteCommand, DeleteCommandInput, GetCommand, GetCommandInput, PutCommand, PutCommandInput, QueryCommand, QueryCommandInput } from "@aws-sdk/lib-dynamodb";
import { Repository, BaseRepository } from "./repository";
import { docClient } from "./dynamodb";
import { Client } from "../models/client.model";


export class ClientRepository extends BaseRepository<Client> implements Repository<Client> {
    constructor(tableName: string) {
        super(tableName);
    }

    async getById(id: string): Promise<Client | null> {

        let filter = new Map<string, string>([
            ["pkey", "id"],
            ["skey", ""]
        ]);

        let data = await super.getByPkey(id, filter);

        if (data === null) {
            return null;
        }

        let client: Client = data as Client;

        delete client.sharedSecret;

        return client;
    }

    async create(data: Client): Promise<void> {

        await super.persist({
            pkey: data.id,
            skey: "client#",
            nickname: data.nickname,
            sharedSecret: data.sharedSecret
        });
    }
    async update(data: Client): Promise<Client> {
        throw new Error("Method not implemented.");
    }
    async delete(id: string): Promise<void> {
        const deleteCommandInput: DeleteCommandInput = {
            TableName: this.tableName,
            Key: {
                skey: id
            }
        };

        await docClient.send(new DeleteCommand(deleteCommandInput));
    }



}

