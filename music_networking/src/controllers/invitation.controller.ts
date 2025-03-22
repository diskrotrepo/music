import { Request, Response } from "express";
import { InvitationService } from "../services/invitation.service";


export class InvitationController {

    private invitationService: InvitationService;

    constructor(invitationService: InvitationService) {
        this.invitationService = invitationService;
    }

    createInvitation = async (req: Request, res: Response): Promise<void> => {
        let clientId = req.headers.clientId as string;
        const code = await this.invitationService.createInvitation(clientId);

        res.status(200).json({ code: code });
    }

    acceptInvitation = async (req: Request, res: Response): Promise<void> => {

        const code = req.params.code;
        await this.invitationService.acceptInvitation(code);


        res.status(200).json({ success: true });
    }

    rejectInvitation = async (req: Request, res: Response): Promise<void> => {
        const code = req.params.code;

        await this.invitationService.rejectInvitation(code);

        res.status(200).json({ success: true });
    }

    getInvitations = async (req: Request, res: Response): Promise<void> => {

        let clientId = req.headers.clientId as string;

        const invitations = await this.invitationService.getInvitations(clientId);

        res.status(200).json({ invitations: invitations });
    }




}

