import { Request, Response } from "express";
import { InvitationService } from "../services/invitation.service";


export class InvitationController {

    private invitationService: InvitationService;

    constructor(invitationService: InvitationService) {
        this.invitationService = invitationService;
    }

    createInvitation = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }

    acceptInvitation = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }

    rejectInvitation = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }

    getInvitations = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ message: "" });
    }




}

