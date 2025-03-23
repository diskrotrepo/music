import { DeleteCommand, PutCommand, PutCommandInput, QueryCommand, QueryCommandInput } from "@aws-sdk/lib-dynamodb"
import { docClient } from "./dynamodb"
import { v4 as uuid } from 'uuid'


export interface Repository<T> {
    getById(id: string): Promise<T | null>
    create(data: T): Promise<void>
    update(data: T): Promise<T>
    delete(id: string): Promise<void>
}

export class BaseRepository<T> {

    protected tableName: string

    constructor(tableName: string) {
        this.tableName = tableName;
    }

    async getByPkey(id: string, mapper?: Map<string, string>): Promise<T | null> {
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

        for (let data of Items) {
        }
        let data = Items[0];

        if (data["pkey"] !== undefined && mapper && mapper.has("pkey")) {
            const newKey = mapper.get("pkey");
            if (newKey) {
                data[newKey] = data["pkey"];
                delete data["pkey"];
            }
        }

        if (data["skey"] !== undefined && mapper && mapper.has("skey")) {
            const newKey = mapper.get("skey");
            if (newKey) {
                data[newKey] = data["skey"];
                delete data["skey"];
            }
        }

        return Items[0] as T;
    }

    async getByPkeyAndSkey(pkey: string, skey: string, mapper?: Map<string, string>): Promise<T | null> {
        const queryCommandInput: QueryCommandInput = {
            TableName: this.tableName,
            KeyConditionExpression: "pkey = :pkey",
            ExpressionAttributeValues: {
                ":pkey": pkey
            }
        };

        const { Items } = await docClient.send(new QueryCommand(queryCommandInput));

        if (Items === undefined || Items.length === 0) {
            return null;
        }

        let data = Items[0];

        if (data["pkey"] !== undefined && mapper && mapper.has("pkey")) {
            const newKey = mapper.get("pkey");
            if (newKey) {
                data[newKey] = data["pkey"];
                delete data["pkey"];
            }
        }

        if (data["skey"] !== undefined && mapper && mapper.has("skey")) {
            const newKey = mapper.get("skey");
            if (newKey) {
                data[newKey] = data["skey"];
                delete data["skey"];
            }
        }

        return Items[0] as T;
    }



    async persist(data: any): Promise<void> {

        if (data.dt_created === undefined) {
            data.dt_created = new Date().toISOString();
        }

        data.dt_updated = new Date().toISOString();

        if (data.row_identifier === undefined) {
            data.row_identifier = uuid();
        }

        let putCommandInput: PutCommandInput = {
            TableName: this.tableName,
            Item: data
        }

        await docClient.send(new PutCommand(putCommandInput));
    }

    async deleteByPkeyAndSkey(pkey: string, skey: string): Promise<void> {
        const command = new DeleteCommand({
            TableName: this.tableName,
            Key: {
                pkey: pkey,
                skey: skey
            },
        });

        await docClient.send(command);


    }

}