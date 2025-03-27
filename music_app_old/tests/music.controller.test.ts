import { Request, Response } from 'express';
import { MusicController } from '../src/server/controllers/music.controller';
import { db } from '../src/server/database';

global.fetch = jest.fn().mockResolvedValue({
    ok: true,
    json: jest.fn().mockResolvedValue({ id: "yup" })
});

jest.mock('../src/server/database', () => ({
    db: {
        prepare: jest.fn()
    }
}));

describe('MusicController', () => {
    let controller: MusicController;
    let req: Partial<Request>;
    let res: Partial<Response>;

    // Dummy prompt result for the LRC query.
    const dummyPrompt = { prompt: 'dummy prompt text', model: 'dummy model' };

    beforeEach(() => {
        controller = new MusicController();
        req = {
            body: {
                title: 'Test Song',
                lyrics: 'These are the lyrics',
                duration: 120,
                steps: 50,
                cfg_strength: 7,
                chunked: false,
                tags: 'pop,rock',
                negative_tags: 'sad',
                input: 'inputFilePath'
            }
        };
        res = {
            json: jest.fn()
        };
        jest.clearAllMocks();
    });

    it('should generate music and respond with task id', async () => {

        const promptGetMock = jest.fn().mockReturnValue(dummyPrompt);

        const runMock = jest.fn();
        (db.prepare as jest.Mock)
            .mockReturnValueOnce({ get: promptGetMock })
            .mockReturnValueOnce({ run: runMock });

        await controller.generate(req as Request, res as Response);

        expect(global.fetch).toHaveBeenCalledWith(
            'http://127.0.0.1:3000/api/v1/lyrics/poet',
            expect.objectContaining({
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    lyrics: req.body.lyrics,
                    duration: req.body.duration,
                    steps: req.body.steps,
                    title: req.body.title,
                    cfg_strength: req.body.cfg_strength,
                    tags: req.body.tags,
                    lrc_prompt: dummyPrompt.prompt,
                    lrc_model: dummyPrompt.model,
                    negative_tags: req.body.negative_tags,
                })
            })
        );

        const expectedSubmitTaskUrl = 'http://<somwhere>//task';

        expect(runMock).toHaveBeenCalledWith(
            "yup",
            "not available",
            req.body.title,
            req.body.lyrics,
            req.body.tags,
            expectedSubmitTaskUrl,
            dummyPrompt.prompt,
            dummyPrompt.model,
            req.body.negative_tags,
            req.body.input,
            req.body.duration,
            req.body.steps,
            req.body.cfg_strength,
            "unknown"
        );

        expect(res.json).toHaveBeenCalledWith({ id: "yup" });
    });
});
