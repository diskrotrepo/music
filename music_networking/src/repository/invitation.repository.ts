import { BaseRepository } from "./repository";


export class InvitationRepository extends BaseRepository<Invitation> {
    constructor(tableName: string) {
        super(tableName);
    }
}

export interface Invitation {
    id: string
    client_id: string
    created_at: string
    updated_at: string
}