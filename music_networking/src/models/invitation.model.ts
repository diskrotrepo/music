import { BaseModel } from "./base.model";


export interface Invitation extends BaseModel {
    code: string;
    sender: string;
    receiver: string;
    status: string;

}