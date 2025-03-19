import { Request, Response } from "express";
import { ConnectionService } from "../services/connection.service";


export class ConnectionController {

    private connectionService: ConnectionService;

    constructor(connectionService: ConnectionService) {
        this.connectionService = connectionService;
    }

    async getConnections(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

    async deleteConnection(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

}

