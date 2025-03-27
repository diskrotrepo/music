
import { Router } from "express";
import { invitationController } from "../controllers";




class InvitationRoutes {
  router = Router();
  invitationController = invitationController;

  constructor() {
    this.intializeRoutes();
  }

  intializeRoutes() {
    // #swagger.tags = ['Invitation']
    // #swagger.summary = 'Returns a list of songs'
    // #swagger.description = 'This will return a list of all songs'

    /* #swagger.responses[200] = {
              description: 'Get a list of your songs.',
              schema: { $ref: '#/definitions/GetLibraryResponse' }
      } */
    this.router.post("/accept/:code", this.invitationController.acceptInvitation);
    // #swagger.tags = ['Invitation']
    // #swagger.summary = 'Performs an action against a song'
    // #swagger.description = 'This allows you to favorite, unfavorite, delete, and restore a song from the trash.'

    /* #swagger.responses[200] = {
              description: 'Successfully update song',
      } */
    this.router.post("", this.invitationController.createInvitation);

    // #swagger.tags = ['Invitation']
    // #swagger.summary = 'Performs an action against a song'
    // #swagger.description = 'This allows you to favorite, unfavorite, delete, and restore a song from the trash.'

    /* #swagger.responses[200] = {
              description: 'Successfully update song',
      } */
    this.router.get("", this.invitationController.getInvitations);


    // #swagger.tags = ['Invitation']
    // #swagger.summary = 'Performs an action against a song'
    // #swagger.description = 'This allows you to favorite, unfavorite, delete, and restore a song from the trash.'

    /* #swagger.responses[200] = {
              description: 'Successfully update song',
      } */
    this.router.delete("/:id", this.invitationController.deleteInvitation);
  }

}


export default new InvitationRoutes().router;