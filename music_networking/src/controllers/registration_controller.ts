import { Request, Response } from "express";


export class RegistrationController {
    async registerClient(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

    async activateRegistration(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

    async getRegistrationStatus(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

    async deleteRegistration(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }


}

