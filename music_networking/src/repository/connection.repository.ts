

export class ConnectionRepository {
    async connect(): Promise<void> {
        console.log("connect");
    }

    async disconnect(): Promise<void> {
        console.log("disconnect");
    }
}