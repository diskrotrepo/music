import { DeleteCommand, DeleteCommandInput, GetCommand, GetCommandInput, PutCommand, PutCommandInput, QueryCommand, QueryCommandInput } from "@aws-sdk/lib-dynamodb";
import { Repository, BaseRepository } from "./repository";
import { docClient } from "./dynamodb";


export class ClientRepository extends BaseRepository<Client> implements Repository<Client> {
    constructor(tableName: string) {
        super(tableName);
    }

    async getById(id: string): Promise<Client | null> {
        const queryCommandInput: QueryCommandInput = {
            TableName: this.tableName,
            KeyConditionExpression: "pkey = :pkey",
            ExpressionAttributeValues: {
                ":pkey": id
            }
        };

        const { Items } = await docClient.send(new QueryCommand(queryCommandInput));

        if (Items === undefined || Items.length === 0) {
            return null;
        }

        Items[0].id = Items[0].pkey;
        Items[0].email = Items[0].skey;
        delete Items[0].skey;
        delete Items[0].pkey;
        delete Items[0].sharedSecret;


        return Items[0] as Client;
    }

    async create(data: Client): Promise<void> {

        await super.persist({
            pkey: data.id,
            skey: data.email,
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

export interface Client {
    id?: string
    nickname: string
    sharedSecret: string
    email: string
    created_at?: string
    updated_at?: string
}