import { BaseModel } from "./base.model"

export interface Client extends BaseModel {
    id?: string
    nickname: string
    sharedSecret?: string
    email?: string

}