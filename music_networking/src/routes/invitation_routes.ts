import { Router } from "express";
import { invitationController } from "../controllers";
import { authorizer } from "../authorization";




class InvitationRoutes {
    router = Router();


    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.post("/:code", authorizer(), invitationController.acceptInvitation);
        this.router.post("", authorizer(), invitationController.createInvitation);
        this.router.get("", authorizer(), invitationController.getInvitations);
        this.router.delete("/:code", authorizer(), invitationController.rejectInvitation);
    }
}

export default new InvitationRoutes().router;

