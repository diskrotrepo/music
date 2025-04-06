import { Request, Response } from "express";
import { ConnectionService } from "../services/connection.service";


export class ConnectionController {

    private connectionService: ConnectionService;

    constructor(connectionService: ConnectionService) {
        this.connectionService = connectionService;
    }

    getConnections = async (req: Request, res: Response): Promise<void> => {
        let clientId = req.headers['client-id'] as string;

        let connections = await this.connectionService.getConnections(clientId);
        res.status(200).json({ connections });

    }

    deleteConnection = async (req: Request, res: Response): Promise<void> => {

        let clientId = req.headers['client-id'] as string;
        let connectionId = req.params.id;

        await this.connectionService.deleteConnection(clientId, connectionId);

        res.status(200).json({ success: true });
    }

}

