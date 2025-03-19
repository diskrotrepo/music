import { Request, Response } from "express";


export class InvitationController {
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

