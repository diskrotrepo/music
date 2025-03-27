import { Request, Response } from 'express';
import { LibraryController, ProcessingStatus, SongAction } from '../src/server/controllers/library.controller';
import { db } from '../src/server/database';

jest.mock('../src/server/database', () => ({
    db: {
        prepare: jest.fn()
    }
}));

describe('LibraryController', () => {
    let controller: LibraryController;
    let req: Partial<Request>;
    let res: Partial<Response>;

    beforeEach(() => {
        controller = new LibraryController();
        req = {};
        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn()
        };
        jest.clearAllMocks();
    });

    describe('getLibrary', () => {
        it('should return 400 if list_view is invalid', () => {
            req.query = { list_view: 'invalid' };

            controller.getLibrary(req as Request, res as Response);

            expect(res.status).toHaveBeenCalledWith(400);
            expect(res.json).toHaveBeenCalledWith({ error: "Invalid list_view. Must be 'library' or 'trash'" });
        });

        it('should return 404 if no songs found', () => {
            req.query = { list_view: 'library' };


            const allMock = jest.fn().mockReturnValue([]);
            (db.prepare as jest.Mock).mockReturnValue({ all: allMock });

            controller.getLibrary(req as Request, res as Response);


            expect(allMock).toHaveBeenCalledWith(0);
            expect(res.status).toHaveBeenCalledWith(404);
            expect(res.json).toHaveBeenCalledWith({ error: "No songs found" });
        });

        it('should return songs when found (library view)', () => {
            req.query = { list_view: 'library' };
            const song = {
                id: '1',
                title: 'Test Song',
                dt_created: '2023-03-18T00:00:00.000Z',
                lyrics: 'Sample lyrics',
                negative_tags: 'none',
                filename: 'test.mp3',
                duration: 300,
                tags: 'tag1,tag2',
                is_favorite: 1,
                is_deleted: 0,
                lrc_id: 'lrc1',
                processing_status: ProcessingStatus.COMPLETE
            };

            const allMock = jest.fn().mockReturnValue([song]);
            (db.prepare as jest.Mock).mockReturnValue({ all: allMock });

            controller.getLibrary(req as Request, res as Response);

            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({ library: expect.any(Array) });


            const library = (res.json as jest.Mock).mock.calls[0][0].library;
            expect(library).toHaveLength(1);
            expect(library[0]).toEqual({
                id: song.id,
                title: song.title,
                filename: song.filename,
                dt_created: new Date(song.dt_created).toISOString(),
                lyrics: song.lyrics,
                duration: song.duration,
                tags: song.tags,
                negative_tags: song.negative_tags,
                lrc_id: song.lrc_id,
                is_favorite: song.is_favorite,
                is_deleted: song.is_deleted,
                processing_status: song.processing_status
            });
        });

        it('should include favorite filter in query if provided', () => {
            req.query = { list_view: 'library', favorite: 'true' };
            const song = {
                id: '1',
                title: 'Test Song',
                dt_created: '2023-03-18T00:00:00.000Z',
                lyrics: 'Sample lyrics',
                negative_tags: null,
                filename: 'test.mp3',
                duration: 300,
                tags: 'tag1',
                is_favorite: 1,
                is_deleted: 0,
                lrc_id: null,
                processing_status: ProcessingStatus.COMPLETE
            };

            const allMock = jest.fn().mockReturnValue([song]);
            (db.prepare as jest.Mock).mockReturnValue({ all: allMock });

            controller.getLibrary(req as Request, res as Response);


            expect(db.prepare).toHaveBeenCalledWith(expect.stringContaining("AND is_favorite = ?"));
            expect(allMock).toHaveBeenCalled();
            expect(res.status).toHaveBeenCalledWith(200);
        });

        it('should work for trash view', () => {
            req.query = { list_view: 'trash' };
            const song = {
                id: '2',
                title: 'Trash Song',
                dt_created: '2023-03-18T00:00:00.000Z',
                lyrics: 'Goodbye',
                negative_tags: null,
                filename: 'trash.mp3',
                duration: 200,
                tags: 'tag3',
                is_favorite: 0,
                is_deleted: 1,
                lrc_id: null,
                processing_status: ProcessingStatus.COMPLETE
            };

            const allMock = jest.fn().mockReturnValue([song]);
            (db.prepare as jest.Mock).mockReturnValue({ all: allMock });

            controller.getLibrary(req as Request, res as Response);


            expect(allMock).toHaveBeenCalledWith(1);
            expect(res.status).toHaveBeenCalledWith(200);
        });
    });

    describe('performAction', () => {
        it('should return 404 if song is not found', () => {
            req.body = { songId: '1', action: SongAction.FAVORITE };


            const getMock = jest.fn().mockReturnValue(undefined);
            (db.prepare as jest.Mock).mockReturnValue({ get: getMock });

            controller.performAction(req as Request, res as Response);

            expect(getMock).toHaveBeenCalledWith('1');
            expect(res.status).toHaveBeenCalledWith(404);
            expect(res.json).toHaveBeenCalledWith({ error: "Song not found" });
        });

        it('should return 400 for invalid action', () => {
            req.body = { songId: '1', action: 999 };
            const song = {
                id: '1',
                title: 'Test Song',
                dt_created: '2023-03-18T00:00:00.000Z',
                lyrics: 'Sample lyrics',
                negative_tags: null,
                filename: 'test.mp3',
                duration: 300,
                tags: 'tag1',
                is_favorite: 0,
                is_deleted: 0,
                lrc_id: null,
                processing_status: ProcessingStatus.NEW
            };


            const getMock = jest.fn().mockReturnValue(song);
            (db.prepare as jest.Mock).mockReturnValue({ get: getMock });

            controller.performAction(req as Request, res as Response);

            expect(res.status).toHaveBeenCalledWith(400);
            expect(res.json).toHaveBeenCalledWith({ error: "Invalid action" });
        });

        it('should update song for FAVORITE action', () => {
            req.body = { songId: '1', action: SongAction.FAVORITE };
            const song = {
                id: '1',
                title: 'Test Song',
                dt_created: '2023-03-18T00:00:00.000Z',
                lyrics: 'Sample lyrics',
                negative_tags: null,
                filename: 'test.mp3',
                duration: 300,
                tags: 'tag1',
                is_favorite: 0,
                is_deleted: 0,
                lrc_id: null,
                processing_status: ProcessingStatus.NEW
            };


            const getMock = jest.fn().mockReturnValue(song);

            const runMock = jest.fn();
            (db.prepare as jest.Mock)
                .mockReturnValueOnce({ get: getMock })
                .mockReturnValueOnce({ run: runMock });

            controller.performAction(req as Request, res as Response);

            expect(runMock).toHaveBeenCalledWith('1');
            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({ success: true });
        });

        it('should update song for UNFAVORITE action', () => {
            req.body = { songId: '1', action: SongAction.UNFAVORITE };
            const song = {
                id: '1',
                title: 'Test Song',
                dt_created: '2023-03-18T00:00:00.000Z',
                lyrics: 'Sample lyrics',
                negative_tags: null,
                filename: 'test.mp3',
                duration: 300,
                tags: 'tag1',
                is_favorite: 1,
                is_deleted: 0,
                lrc_id: null,
                processing_status: ProcessingStatus.NEW
            };

            const getMock = jest.fn().mockReturnValue(song);
            const runMock = jest.fn();
            (db.prepare as jest.Mock)
                .mockReturnValueOnce({ get: getMock })
                .mockReturnValueOnce({ run: runMock });

            controller.performAction(req as Request, res as Response);

            expect(runMock).toHaveBeenCalledWith('1');
            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({ success: true });
        });

        it('should update song for DELETE action', () => {
            req.body = { songId: '1', action: SongAction.DELETE };
            const song = {
                id: '1',
                title: 'Test Song',
                dt_created: '2023-03-18T00:00:00.000Z',
                lyrics: 'Sample lyrics',
                negative_tags: null,
                filename: 'test.mp3',
                duration: 300,
                tags: 'tag1',
                is_favorite: 1,
                is_deleted: 0,
                lrc_id: null,
                processing_status: ProcessingStatus.NEW
            };

            const getMock = jest.fn().mockReturnValue(song);
            const runMock = jest.fn();
            (db.prepare as jest.Mock)
                .mockReturnValueOnce({ get: getMock })
                .mockReturnValueOnce({ run: runMock });

            controller.performAction(req as Request, res as Response);

            expect(runMock).toHaveBeenCalledWith('1');
            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({ success: true });
        });

        it('should update song for RESTORE action', () => {
            req.body = { songId: '1', action: SongAction.RESTORE };
            const song = {
                id: '1',
                title: 'Test Song',
                dt_created: '2023-03-18T00:00:00.000Z',
                lyrics: 'Sample lyrics',
                negative_tags: null,
                filename: 'test.mp3',
                duration: 300,
                tags: 'tag1',
                is_favorite: 1,
                is_deleted: 1,
                lrc_id: null,
                processing_status: ProcessingStatus.NEW
            };

            const getMock = jest.fn().mockReturnValue(song);
            const runMock = jest.fn();
            (db.prepare as jest.Mock)
                .mockReturnValueOnce({ get: getMock })
                .mockReturnValueOnce({ run: runMock });

            controller.performAction(req as Request, res as Response);

            expect(runMock).toHaveBeenCalledWith('1');
            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({ success: true });
        });
    });
});
