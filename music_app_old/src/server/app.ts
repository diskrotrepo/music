import express, { Application } from "express";
import Server from "./server";


export function startServer() {

    const app: Application = express();
    const server: Server = new Server(app);
    const PORT: number = process.env.PORT ? parseInt(process.env.PORT, 10) : 3000;

    app
        .listen(PORT, "127.0.0.1", function () {
            console.log(`Server is running on port ${PORT}.`);
        })
        .on("error", (err: any) => {
            if (err.code === "EADDRINUSE") {
                console.log("Error: address already in use");
            } else {
                console.log(err);
            }
        });
}