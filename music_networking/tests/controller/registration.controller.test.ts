import { Request, Response } from "express";
import { RegistrationService } from "../../src/services/registration.service";
import { RegistrationController } from "../../src/controllers/registration.controller";


describe('RegistrationController', () => {
    let registrationService: RegistrationService;
    let registrationController: RegistrationController;
    let req: Partial<Request>;
    let res: Partial<Response>;

    beforeEach(() => {
        registrationService = {
            registerClient: jest.fn()
        } as unknown as RegistrationService;


        registrationController = new RegistrationController(registrationService);


        req = {
            body: {
                email: 'test@example.com',
                nickname: 'testuser'
            }
        };


        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn()
        };
    });

    it('should register a client and return client info with 200 status', async () => {

        const mockClient = {
            id: 'uuid-1234',
            email: 'test@example.com',
            nickname: 'testuser',
            sharedSecret: 'abcdef1234567890abcdef1234567890',
            created_at: new Date().toISOString(),
            updated_at: new Date().toISOString()
        };

        (registrationService.registerClient as jest.Mock).mockResolvedValue(mockClient);


        await registrationController.registerClient(req as Request, res as Response);

        expect(registrationService.registerClient).toHaveBeenCalledWith('test@example.com', 'testuser');
        expect(res.status).toHaveBeenCalledWith(200);
        expect(res.json).toHaveBeenCalledWith({ client: mockClient });
    });
});
