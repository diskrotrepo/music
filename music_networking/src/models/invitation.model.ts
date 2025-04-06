import { BaseModel } from "./base.model";


export interface Invitation extends BaseModel {
    nickname?: string;
    code: string;
    client_id: string;
    accepted_client_id?: string
}