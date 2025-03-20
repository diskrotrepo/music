import { Request, Response } from "express";
import { ClientService } from "../services/client.service";


export class ClientController {

    private clientService: ClientService;

    constructor(clientService: ClientService) {
        this.clientService = clientService;
    }

    updateSettings = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }

    getSettings = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }

    getClient = async (req: Request, res: Response): Promise<void> => {
        let id = req.params.id;
        const client = await this.clientService.getClient(id);

        if (client === null) {
            res.status(404).json({ message: "Client not found" });
            return;
        }

        res.status(200).json(client);
    }

    deleteClient = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }

}

