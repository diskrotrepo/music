import { QueryCommand, UpdateCommand } from "@aws-sdk/lib-dynamodb";
import { Queue } from "../models/queue.model";
import { docClient } from "./dynamodb";
import { BaseRepository } from "./repository";


export class QueueRepository extends BaseRepository<Queue> {
    constructor(tableName: string) {
        super(tableName);
    }

    async enQueue(requestingClientId: string, destinationClientId: string, data: any): Promise<void> {

        await super.persist({
            pkey: destinationClientId,
            skey: `queue#${Date.now()}#requesting_client_id#${data.client_id}`,
            processing_status: 'NEW',
            data: data,
            client_id: data.client_id,
            music_id: data.music_id
        });
    }

    async getByMusicId(queueId: string): Promise<Queue | null> {

        const results = await super.getByGSI('music_id-index', "music_id", queueId);

        if (results === null) {
            return null;
        }

        if (results.length !== 1) {
            throw new Error("Expected 1 result, got " + results.length);
        }

        return results[0];
    }

    async getWorkForClient(requestingClientId: string, limit: number): Promise<Array<Queue> | null> {

        const inProgressCountResult = await docClient.send(
            new QueryCommand({
                TableName: this.tableName,
                KeyConditionExpression: "pkey = :pkey",
                FilterExpression: "#s = :processing_status",
                ExpressionAttributeNames: {
                    "#s": "processing_status",
                },
                ExpressionAttributeValues: {
                    ":pkey": requestingClientId,
                    ":processing_status": "IN-PROGRESS",
                },
                Select: "COUNT",
            })
        );

        const currentInProgressCount = inProgressCountResult.Count ?? 0;
        console.log("Current in-progress count:", currentInProgressCount);

        if (currentInProgressCount >= limit) {
            console.log(`Already have ${currentInProgressCount} in-progress. Not fetching more.`);
            return [];
        }

        const remainingSlots = limit - currentInProgressCount;

        console.log("Remaining capacity:", remainingSlots);

        const queryCommandInput = {
            TableName: this.tableName,
            KeyConditionExpression: "pkey = :pkey",
            FilterExpression: "#s = :processing_status",
            ExpressionAttributeNames: {
                "#s": "processing_status",
            },
            ExpressionAttributeValues: {
                ":pkey": requestingClientId,
                ":processing_status": "NEW",
            },
            Limit: remainingSlots,
        };

        const { Items } = await docClient.send(new QueryCommand(queryCommandInput));

        if (Items && Items.length > 0) {
            for (const item of Items) {

                await docClient.send(
                    new UpdateCommand({
                        TableName: this.tableName,
                        Key: {
                            pkey: item.pkey,
                            skey: item.skey,
                        },
                        UpdateExpression: "SET #s = :processing_status",
                        ExpressionAttributeNames: {
                            "#s": "processing_status",
                        },
                        ExpressionAttributeValues: {
                            ":processing_status": "IN-PROGRESS",
                        },
                    })
                );
            }
        } else {
            console.log("No items found for client");
        }

        return Items as Array<Queue>;

    }
}


