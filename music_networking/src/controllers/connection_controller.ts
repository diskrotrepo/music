import { Request, Response } from "express";


export class ConnectionController {
    async getConnections(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

    async deleteConnection(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

}

