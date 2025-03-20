import { Request, Response } from "express";
import { RegistrationService } from "../services/registration.service";

export class RegistrationController {

    private registrationService: RegistrationService;

    constructor(registrationService: RegistrationService) {
        this.registrationService = registrationService;


    }

    registerClient = async (req: Request, res: Response): Promise<void> => {

        const { email, nickname } = req.body;
        console.log(email, nickname);
        const client = await this.registrationService.registerClient(email, nickname);


        res.status(200).json({ client: client });
    }

    activateRegistration = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }

    getRegistrationStatus = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }

    deleteRegistration = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }


}

