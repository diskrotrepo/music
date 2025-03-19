import { Router } from "express";
import { InvitationController } from "../controllers/invitation_controller";
import { invitationService } from "../services";



class InvitationRoutes {
    router = Router();
    invitationController = new InvitationController(invitationService);

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.post("/invitation/:code", this.invitationController.acceptInvitation);
        this.router.post("", this.invitationController.createInvitation);
        this.router.get("", this.invitationController.getInvitations);
        this.router.delete("/:code", this.invitationController.rejectInvitation);
    }
}

export default new InvitationRoutes().router;

