import { BaseModel } from "./base.model";

export interface Connection extends BaseModel {
    clientId: string
    connected_to_client: string
    invitation_code: string
}   