import { ConnectionController } from "./connection.controller";
import { InvitationController } from "./invitation.controller";
import { LibraryController } from "./library.controller";
import { MusicController } from "./music.controller";
import { QueueController } from "./queue.controller";
import { SettingsController } from "./settings.controller";
import { StatusController } from "./status.controller";



export const libraryController = new LibraryController();
export const musicController = new MusicController();
export const settingController = new SettingsController();
export const statusController = new StatusController();
export const queueController = new QueueController();
export const invitationController = new InvitationController();
export const connectionConntroller = new ConnectionController();