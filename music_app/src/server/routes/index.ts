import { Application } from "express";
import libraryRoutes from "./library.routes";
import musicRoutes from "./music.routes";
import statusRoutes from "./status.routes";
import settingsRoutes from "./settings.routes";


export default class Routes {
    constructor(app: Application) {
        app.use("/api/v1/library", libraryRoutes);
        app.use("/api/v1/music", musicRoutes);
        app.use("/api/v1/status", statusRoutes);
        app.use("/api/v1/settings", settingsRoutes);
    }
}