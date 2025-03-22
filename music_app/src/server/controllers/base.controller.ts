import { db } from "../database";
import DiskrotNetwork from "../network";



export class BaseController {
    private static _diskrotNetwork: DiskrotNetwork;

    get diskrotNetwork(): DiskrotNetwork {

        if (BaseController._diskrotNetwork) {
            return BaseController._diskrotNetwork;
        }

        const result = db.prepare("SELECT * FROM client").get() as { id: string, nickname: string, shared_secret: string };

        if (result) {
            BaseController._diskrotNetwork = new DiskrotNetwork({
                id: result.id,
                sharedSecret: result.shared_secret
            });
            console.log("diskrot client initialized");
            return BaseController._diskrotNetwork;
        } else {
            console.error("No client found in database");
            return null;
        }


    }

}