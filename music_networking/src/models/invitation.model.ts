import { BaseModel } from "./base.model";


export interface Invitation extends BaseModel {
    code: string;
    client_id: string;
    accepted_client_id?: string
}