import { Request, Response } from "express";
import { ClientService } from "../services/client.service";


export class ClientController {

    private clientService: ClientService;

    constructor(clientService: ClientService) {
        this.clientService = clientService;
    }

    async updateSettings(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

    async getSettings(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

}

