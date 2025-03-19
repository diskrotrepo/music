import { GenerationRepository } from "../repository/generation.repository";


export class GenerationService {
    private generationRepository: GenerationRepository;

    constructor(generationRepository: GenerationRepository) {
        this.generationRepository = generationRepository;
    }
}