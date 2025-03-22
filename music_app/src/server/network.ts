import configuration from '../../config/configuration.json';
import * as crypto from 'crypto';
import { db } from "./database";
import { useClientStore } from '../stores/clientStore';

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
            console.error(response);
            throw new Error(`Networking issue communicating with Diskrot POST: ${configuration.diskrot}${url}`);
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
            console.error(response);
            throw new Error(`Networking issue communicating with Diskrot GET: ${configuration.diskrot}${url}`);
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
            console.error(response);
            throw new Error(`Networking issue communicating with Diskrot PUT: ${configuration.diskrot}${url}`);
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
            console.error(response);
            throw new Error(`Networking issue communicating with Diskrot PATCH: ${configuration.diskrot}${url}`);
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
            console.error(response);
            throw new Error(`Networking issue communicating with Diskrot DELETE: ${configuration.diskrot}${url}`);
        }

        return await response.json();
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

