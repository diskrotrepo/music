import configuration from '../../config/configuration.json';
import * as crypto from 'crypto';
import { db } from "./database";


interface RequestData {
    url: string;
    payload: any;
}

interface Client {
    id: string;
    sharedSecret: string;
}

export default class DiskrotNetwork {

    client: Client;

    constructor(client: Client) {
        this.client = client;
    }

    getClient = (): Client => {
        return this.client;
    }

    buildUrl = (url: string): string => {
        let fullUrl = configuration.diskrot.secure == true ? "https://" : "http://";
        fullUrl += configuration.diskrot.hostname + ":" + configuration.diskrot.port;
        fullUrl += configuration.diskrot.api + url;

        return fullUrl;
    }

    post = async (url: string, payload: any): Promise<any> => {

        const fullUrl = this.buildUrl(url);

        console.log("fullUrl", fullUrl);

        const response = await fetch(
            fullUrl,
            {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'client-id': this.client.id,
                    'diskrot-signature': this.computeHMAC({
                        url: configuration.diskrot.api + url,
                        payload: payload
                    })
                },
                body: JSON.stringify(payload)
            }
        );


        if (!response.ok) {
            this.errorHandling(fullUrl, response);
        }

        return await response.json();
    }

    get = async (url: string): Promise<any> => {
        const fullUrl = this.buildUrl(url);

        const response = await fetch(
            fullUrl,
            {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'client-id': this.client.id,
                    'diskrot-signature': this.computeHMAC({
                        url: configuration.diskrot.api + url,
                        payload: {}
                    })
                },
            }
        );

        if (!response.ok) {
            return this.errorHandling(fullUrl, response);
        }

        return await response.json();
    }

    put = async (url: string, payload: any): Promise<any> => {
        const fullUrl = this.buildUrl(url);

        const response = await fetch(
            fullUrl,
            {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'client-id': this.client.id,
                    'diskrot-signature': this.computeHMAC({
                        url: configuration.diskrot.api + url,
                        payload: payload
                    })
                },
                body: JSON.stringify(payload)
            }
        );

        if (!response.ok) {
            return this.errorHandling(fullUrl, response);
        }

        return await response.json();
    }

    patch = async (url: string, payload: any): Promise<any> => {
        const fullUrl = this.buildUrl(url);

        const response = await fetch(
            fullUrl,
            {
                method: 'PATCH',
                headers: {
                    'Content-Type': 'application/json',
                    'client-id': this.client.id,
                    'diskrot-signature': this.computeHMAC({
                        url: configuration.diskrot.api + url,
                        payload: payload
                    })
                },
                body: JSON.stringify(payload)
            }
        );

        if (!response.ok) {
            return this.errorHandling(fullUrl, response);
        }

        return await response.json();
    }

    delete = async (url: string): Promise<any> => {
        const fullUrl = this.buildUrl(url);

        const response = await fetch(
            fullUrl,
            {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                    'client-id': this.client.id,
                    'diskrot-signature': this.computeHMAC({
                        url: configuration.diskrot.api + url,
                        payload: {}
                    })
                },
            }
        );

        if (!response.ok) {
            return this.errorHandling(fullUrl, response);
        }

        return await response.json();
    }

    errorHandling = (fullUrl: string, response: any) => {

        if (response.status === 401) {
            console.error(response);
        }
    }

    createDigestString(data: RequestData): string {
        return `${this.client.id}|${data.url}|${JSON.stringify(data.payload)}`;
    }

    computeHMAC(data: RequestData): string {
        const digestString = this.createDigestString(data);

        const digest = crypto.createHmac('sha256', this.client.sharedSecret)
            .update(digestString)
            .digest('hex');

        return digest;
    }
}



async function poll(fetchFn: () => Promise<void>, interval = 1000) {
    while (true) {
        try {
            await fetchFn();
            await new Promise((resolve) => setTimeout(resolve, interval));
        } catch (error) {
            console.error("Polling error:", error);
        }
    }
}

async function fetchData(): Promise<void> {
    const client = DiskrotNetworkClient.diskrotNetworkClient.getClient();

    try {
        await DiskrotNetworkClient.diskrotNetworkClient.get(`/queue`);
    } catch (error) {
        if (error.code == "ECONNREFUSED") {
            console.error("diskrot network unavailable.");
        } else {
            console.error("Failed to fetch data:", error);
        }

    }
}

(async () => {
    try {
        await poll(fetchData, 2000);
    } catch (err) {
        console.error("Polling stopped unexpectedly:", err);
    }
})();


export class DiskrotNetworkClient {
    private static _diskrotNetwork: DiskrotNetwork = null;

    static get diskrotNetworkClient(): DiskrotNetwork {

        if (!DiskrotNetworkClient._diskrotNetwork) {

            const result = db.prepare("SELECT * FROM client").get() as { id: string, nickname: string, shared_secret: string };

            if (result) {
                DiskrotNetworkClient._diskrotNetwork = new DiskrotNetwork({
                    id: result.id,
                    sharedSecret: result.shared_secret
                });
                console.log("diskrot client initialized");
                return DiskrotNetworkClient._diskrotNetwork;
            } else {
                console.error("No client found in database");
                return null;
            }
        }

        return DiskrotNetworkClient._diskrotNetwork;
    }
}