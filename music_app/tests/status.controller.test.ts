import { Request, Response } from 'express';
import { StatusController } from '../src/server/controllers/status.controller';
import { db } from '../src/server/database';
import configuration from '../config/configuration.json';

jest.mock('../src/server/database', () => ({
    db: {
        prepare: jest.fn()
    }
}));

describe('StatusController', () => {
    let controller: StatusController;
    let req: Partial<Request>;
    let res: Partial<Response>;

    beforeEach(() => {
        controller = new StatusController();
        req = { params: { id: '123' } };
        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn()
        };
        jest.clearAllMocks();
    });

    it('should return an error response if fetch response is not ok', async () => {
        const fakeResponse = {
            ok: false,
            status: 404,
            json: jest.fn()
        };
        global.fetch = jest.fn().mockResolvedValue(fakeResponse);

        await controller.getStatus(req as Request, res as Response);


        const endpoint = `/api/v1/status/${req.params.id}`;
        const checkStatusUrl = `${configuration.inference_server}/${endpoint}`;
        expect(res.status).toHaveBeenCalledWith(404);
        expect(res.json).toHaveBeenCalledWith({ error: `No song found at ${checkStatusUrl}` });
    });

    it('should update db and return data if processing_status is COMPLETE', async () => {

        const data = {
            processing_status: "COMPLETE",
            filename: "s3://song.mp3",
            otherField: "value"
        };
        const fakeResponse = {
            ok: true,
            status: 200,
            json: jest.fn().mockResolvedValue(data)
        };
        global.fetch = jest.fn().mockResolvedValue(fakeResponse);


        const runMock = jest.fn();
        (db.prepare as jest.Mock).mockReturnValue({ run: runMock });

        await controller.getStatus(req as Request, res as Response);

        expect(runMock).toHaveBeenCalledWith("COMPLETE", "song.mp3", req.params.id);
        expect(res.status).toHaveBeenCalledWith(200);
        expect(res.json).toHaveBeenCalledWith({
            ...data,
            filename: "song.mp3"
        });
    });

    it('should return data without updating db if processing_status is not COMPLETE', async () => {

        const data = {
            processing_status: "IN_PROGRESS",
            filename: "s3://song.mp3",
            otherField: "value"
        };
        const fakeResponse = {
            ok: true,
            status: 200,
            json: jest.fn().mockResolvedValue(data)
        };
        global.fetch = jest.fn().mockResolvedValue(fakeResponse);

        const runMock = jest.fn();
        (db.prepare as jest.Mock).mockReturnValue({ run: runMock });

        await controller.getStatus(req as Request, res as Response);

        expect(runMock).not.toHaveBeenCalled();
        expect(res.status).toHaveBeenCalledWith(200);
        expect(res.json).toHaveBeenCalledWith(data);
    });

    it('should return 500 error if fetch throws an error', async () => {
        const error = new Error("Test error");
        global.fetch = jest.fn().mockRejectedValue(error);

        await controller.getStatus(req as Request, res as Response);

        expect(res.status).toHaveBeenCalledWith(500);
        expect(res.json).toHaveBeenCalledWith({ error: error.message || "Internal server error" });
    });
});
