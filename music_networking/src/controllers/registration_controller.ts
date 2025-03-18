import { Request, Response } from "express";


export class RegistrationCntroller {
    async register(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

    async confirmRegistration(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }
}

