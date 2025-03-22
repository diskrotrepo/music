import { Request, Response } from "express";
import { RegistrationService } from "../services/registration.service";

export class RegistrationController {

    private registrationService: RegistrationService;

    constructor(registrationService: RegistrationService) {
        this.registrationService = registrationService;


    }

    registerClient = async (req: Request, res: Response): Promise<void> => {

        const nickname = req.body.nickname;
        console.log(nickname);
        const client = await this.registrationService.registerClient(nickname);


        res.status(200).json({ client: client });
    }

    activateRegistration = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }

    getRegistrationStatus = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }

    deleteRegistration = async (req: Request, res: Response): Promise<void> => {
        console.log("deleteRegistration");
        res.status(200).json({ message: "" });
    }


}

