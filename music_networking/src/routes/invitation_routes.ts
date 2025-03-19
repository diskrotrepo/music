import { Router } from "express";
import { InvitationController } from "../controllers/invitation_controller";



class InvitationRoutes {
    router = Router();
    invitationController = new InvitationController();

    constructor() {
        this.intializeRoutes();
    }

    intializeRoutes() {
        this.router.post("/invitation", this.invitationController.acceptInvitation);
        this.router.post("/confirm", this.invitationController.createInvitation);
        this.router.get("/confirm", this.invitationController.getInvitations);
        this.router.delete("/confirm", this.invitationController.rejectInvitation);
    }
}

export default new InvitationRoutes().router;

