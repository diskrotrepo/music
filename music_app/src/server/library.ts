
import { Request, Response } from 'express';

interface Song {
    title: string
    dt_created: string
    lyrics: string
    duration: number
    tags: string
    negative_tags: string
    lrc_id: string
    processing_status: ProcessingStatus
}

enum ProcessingStatus {
    NEW,
    IN_PROGRESS,
    COMPLETE,
    ERROR
}

enum SongAction {
    FAVORITE,
    UNFAVORITE,
    DELETE,
    RESTORE
}

export class LibraryController {

    public getLibrary(req: Request, res: Response): void {


        const data: Array<Song> = [
            {
                title: "Banger #12",
                dt_created: "2025-03-12T00:00:00+05:00",
                lyrics: "I am a song. (la la la)",
                duration: 95,
                tags: "rock and roll, hip hop",
                negative_tags: "heavy metal, noise",
                lrc_id: "b7e6a5d9-5f42-4a8b-9a38-47ef2e2a8df1",
                processing_status: ProcessingStatus.NEW
            }
        ]

        res.json({ "library": data });
    }

    public performAction(req: Request, res: Response): void {
        const { id } = req.params;

        const data = { id, status: 'Active' };

        res.json(data);
    }

}