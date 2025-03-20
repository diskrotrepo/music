import { Router } from "express";
import { invitationController } from "../controllers";




class InvitationRoutes {
    router = Router();


    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.post("/invitation/:code", invitationController.acceptInvitation);
        this.router.post("", invitationController.createInvitation);
        this.router.get("", invitationController.getInvitations);
        this.router.delete("/:code", invitationController.rejectInvitation);
    }
}

export default new InvitationRoutes().router;

