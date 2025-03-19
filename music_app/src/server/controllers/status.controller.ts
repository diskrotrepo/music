import { Request, Response } from 'express';
import { db } from '../database';
import configuration from '../../../config/configuration.json'

export class StatusController {

    async getStatus(req: Request, res: Response): Promise<void> {

        const { id } = req.params;

        const endpoint = `/api/v1/status/${id}`;
        const checkStatusUrl = `${configuration.inference_server}/${endpoint}`;

        console.info(`Checking status of song with id: ${id}`);

        try {
            const response = await fetch(checkStatusUrl);


            if (!response.ok) {
                res.status(response.status).json({ error: `No song found at ${checkStatusUrl}` });
                return;
            }

            const data = await response.json();


            if (data.processing_status === "COMPLETE") {

                data.filename = data.filename.replace("s3://", "");

                const updateQuery = `
                    UPDATE music
                    SET processing_status = ?, filename = ?
                    WHERE id = ?
                `;

                db.prepare(updateQuery).run("COMPLETE", data.filename, id);

                res.status(200).json(data);
                return;
            }

            res.status(200).json(data);
        } catch (error: any) {
            console.error("Error checking song status:", error);
            res.status(500).json({ error: error.message || "Internal server error" });
        }
    }
}