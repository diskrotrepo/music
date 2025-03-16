import { Request, Response } from 'express';

export class StatusController {

    public getStatus(req: Request, res: Response): void {
        const { id } = req.params;

        const data = {
            status: {
                "id": "b7e6a5d9-5f42-4a8b-9a38-47ef2e2a8df1",
                "title": "Banger #1",
                "filename": "s3://bucket/folder/song.wav",
                "dt_created": "2025-03-12T00:00:00+05:00",
                "processing_status": "NEW"
            }
        };

        res.json(data);
    }
}