import { Request, Response } from "express";
import { InvitationService } from "../services/invitation.service";
import { client } from "../repository/dynamodb";


export class InvitationController {

    private invitationService: InvitationService;

    constructor(invitationService: InvitationService) {
        this.invitationService = invitationService;
    }

    createInvitation = async (req: Request, res: Response): Promise<void> => {

        let clientId = req.headers['client-id'] as string;
        const code = await this.invitationService.createInvitation(clientId);
        res.status(200).json({ code: code });
    }

    acceptInvitation = async (req: Request, res: Response): Promise<void> => {
        let clientId = req.headers['client-id'] as string;
        const code = req.params.code;
        let connection = await this.invitationService.acceptInvitation(clientId, code) as { nickname: string, client_id: string } | null;


        if (connection === null) {
            res.status(400).json({ error: "Unable to accept invitation" });
            return;
        }

        res.status(200).json({ nickname: connection.nickname, client_id: connection.client_id });
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

