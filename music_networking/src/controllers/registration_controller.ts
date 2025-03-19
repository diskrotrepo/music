import { Request, Response } from "express";
import { RegistrationService } from "../services/registration.service";


export class RegistrationController {

    private registrationService: RegistrationService;

    constructor(registrationService: RegistrationService) {
        this.registrationService = registrationService;
    }

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

