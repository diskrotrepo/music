import { PutCommand, PutCommandInput } from "@aws-sdk/lib-dynamodb"
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

    async persist(data: any): Promise<void> {

        data.dt_created = new Date().toISOString();
        data.dt_updated = new Date().toISOString();
        data.row_identifier = uuid();

        let putCommandInput: PutCommandInput = {
            TableName: this.tableName,
            Item: data
        }

        await docClient.send(new PutCommand(putCommandInput));
    }


}