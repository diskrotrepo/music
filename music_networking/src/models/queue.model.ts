import { BaseModel } from "./base.model";


export interface Queue extends BaseModel {
    id: string
    client_id: string
    created_at: string
    updated_at: string
    processing_status: string
    filename?: string
}