import { ClientRepository } from "../../src/repository/client.repository";
import { RegistrationService } from "../../src/services/registration.service";


// Create a mock of the ClientRepository
const mockClientRepository: Partial<ClientRepository> = {
    create: jest.fn().mockResolvedValue(undefined),
};

describe('RegistrationService', () => {
    let registrationService: RegistrationService;

    beforeEach(() => {
        jest.clearAllMocks();
        registrationService = new RegistrationService(mockClientRepository as ClientRepository);
    });

    it('should register a client with valid details', async () => {
        const email = 'test@example.com';
        const nickname = 'testuser';

        const client = await registrationService.registerClient(email);

        expect(client.email).toBe(email);
        expect(client.nickname).toBe(nickname);

        expect(client.id).toBeDefined();

        expect(client.sharedSecret).toHaveLength(32);



        expect(mockClientRepository.create).toHaveBeenCalledWith(client);
    });
});
