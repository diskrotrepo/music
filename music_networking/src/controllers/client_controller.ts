import { Request, Response } from "express";


export class ClientController {
    async updateSettings(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

    async getSettings(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

}

