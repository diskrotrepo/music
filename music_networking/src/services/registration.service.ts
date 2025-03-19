import { RegistrationRepository } from "../repository/registration.repository";


export class RegistrationService {
    private registrationRepository: RegistrationRepository;

    constructor(registrationRepository: RegistrationRepository) {
        this.registrationRepository = registrationRepository;
    }
}