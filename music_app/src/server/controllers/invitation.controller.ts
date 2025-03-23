import { Request, Response } from 'express';
import { db } from '../database';
import configuration from '../../../config/configuration.json'
import DiskrotNetwork from '../network';
import { v4 as uuid } from 'uuid'
import { BaseController } from './base.controller';

export class InvitationController extends BaseController {


    constructor() {
        super();
    }

    acceptInvitation = async (req: Request, res: Response): Promise<void> => {

        let invitation = db.prepare("SELECT * FROM invitations WHERE code = ?").get([req.params.code]);

        if (invitation) {
            res.status(400).json({ error: "You can't accept your own invitations." });
            return;
        }

        console.log("Accepting invitation");

        let response = await this.diskrotNetwork.post(`/invitation/${req.params.code}`, {});

        db.prepare("INSERT INTO connections (id, nickname, direction) VALUES (?,?,?)").run([uuid(), response.nickname, "OUTBOUND"]);

        res.status(200).json({});
    }

    getInvitations = async (req: Request, res: Response): Promise<void> => {

        let invitations = db.prepare("SELECT * FROM invitations").all();


        res.status(200).json(invitations);
    }

    createInvitation = async (req: Request, res: Response): Promise<void> => {

        let invitationCreateResponse = await this.diskrotNetwork.post("/invitation", {}) as InvitationCreateResponse;

        db.prepare("INSERT INTO invitations (id, code) VALUES (?,?)").run([uuid(), invitationCreateResponse.code]);

        res.status(200).json(invitationCreateResponse);
    }

    deleteInvitation = async (req: Request, res: Response): Promise<void> => {
        db.prepare("DELETE FROM invitations WHERE id = ?").run([req.params.id]);
        res.status(200).json({});
    }
}

interface InvitationCreateResponse {
    code: string;
}