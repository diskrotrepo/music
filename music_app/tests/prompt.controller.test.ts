import { Request, Response } from 'express';

import { db } from '../src/server/database';
import { PromptController, Prompt } from '../src/server/controllers/prompt.controller';

jest.mock('../src/server/database', () => ({
    db: {
        prepare: jest.fn()
    }
}));

describe('PromptController', () => {
    let controller: PromptController;
    let req: Partial<Request>;
    let res: Partial<Response>;

    beforeEach(() => {
        controller = new PromptController();
        req = {};
        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn()
        };
        jest.clearAllMocks();
    });

    describe('updatePrompt', () => {
        it('should update the prompt and return success', () => {
            // Arrange
            const samplePrompt: Prompt = {
                prompt: 'Sample prompt text',
                model: 'sample-model',
                category: 'sample-category',
                is_default: true
            };
            req.body = samplePrompt;

            const runMock = jest.fn();

            (db.prepare as jest.Mock).mockReturnValue({ run: runMock });

            controller.updatePrompt(req as Request, res as Response);

            expect(db.prepare).toHaveBeenCalledWith(expect.stringContaining("UPDATE prompt SET prompt = ?, model = ?"));
            expect(runMock).toHaveBeenCalledWith([
                samplePrompt.prompt,
                samplePrompt.model,
                samplePrompt.category
            ]);
            expect(res.json).toHaveBeenCalledWith({ success: true });
        });
    });

    describe('getPrompt', () => {
        it('should return 400 if id is missing', () => {

            req.params = {};
            controller.getPrompt(req as Request, res as Response);

            expect(res.status).toHaveBeenCalledWith(400);
            expect(res.json).toHaveBeenCalledWith({ error: "Missing id parameter" });
        });

        it('should return 404 if prompt is not found', () => {

            req.params = { id: 'nonexistent' };

            const getMock = jest.fn().mockReturnValue(undefined);
            (db.prepare as jest.Mock).mockReturnValue({ get: getMock });


            controller.getPrompt(req as Request, res as Response);


            expect(db.prepare).toHaveBeenCalledWith(expect.stringContaining("SELECT * FROM prompt WHERE category = ? AND is_default = 1"));
            expect(getMock).toHaveBeenCalledWith('nonexistent');
            expect(res.status).toHaveBeenCalledWith(404);
            expect(res.json).toHaveBeenCalledWith({ error: "Prompt nonexistent not found" });
        });

        it('should return the prompt if found', () => {

            req.params = { id: 'existing' };

            const samplePrompt: Prompt = {
                prompt: 'Found prompt text',
                model: 'found-model',
                category: 'existing',
                is_default: true
            };

            const getMock = jest.fn().mockReturnValue(samplePrompt);
            (db.prepare as jest.Mock).mockReturnValue({ get: getMock });


            controller.getPrompt(req as Request, res as Response);


            expect(db.prepare).toHaveBeenCalledWith(expect.stringContaining("SELECT * FROM prompt WHERE category = ? AND is_default = 1"));
            expect(getMock).toHaveBeenCalledWith('existing');
            expect(res.json).toHaveBeenCalledWith(samplePrompt);
        });
    });
});
