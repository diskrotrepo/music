import { db } from "../database";
import DiskrotNetwork, { DiskrotNetworkClient } from "../network";



export class BaseController {

    get diskrotNetwork(): DiskrotNetwork {
        return DiskrotNetworkClient.diskrotNetworkClient;
    }
}