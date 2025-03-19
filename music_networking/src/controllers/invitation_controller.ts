import { Request, Response } from "express";
import { InvitationService } from "../services/invitation.service";


export class InvitationController {

    private invitationService: InvitationService;

    constructor(invitationService: InvitationService) {
        this.invitationService = invitationService;
    }

    async createInvitation(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

    async acceptInvitation(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

    async rejectInvitation(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }

    async getInvitations(req: Request, res: Response): Promise<void> {
        res.status(200).json({ message: "" });
    }




}

