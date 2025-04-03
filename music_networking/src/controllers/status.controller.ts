import { Request, Response } from "express";


export class StatusController {


    constructor() {
    }

    health = async (req: Request, res: Response): Promise<void> => {
        res.status(200).json({ status: "ok" });
    }

}

