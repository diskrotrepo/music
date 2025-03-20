import { BaseRepository } from "./repository";

export class GenerationRepository extends BaseRepository<Generation> {
    constructor(tableName: string) {
        super(tableName);
    }
}

export interface Generation {
    id: string
}

export interface Music extends Generation {
    title: string
    lyrics: string
    duration: number
    steps: number
    cfg_strength: number
    chunked: boolean
    tags: string
    negative_tags: string
}

export interface Lyrics extends Generation {
    lyrics: string
}