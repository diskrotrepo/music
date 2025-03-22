import { LibraryController } from "./library.controller";
import { MusicController } from "./music.controller";
import { SettingsController } from "./settings.controller";
import { StatusController } from "./status.controller";


export const libraryController = new LibraryController();
export const musicController = new MusicController();
export const settingController = new SettingsController();
export const statusController = new StatusController();