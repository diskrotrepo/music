import { Request, Response, NextFunction } from 'express';
import crypto from 'crypto';
import { Client } from './models/client.model';
import { clientRepository } from './repository';

export function authorizer() {

    return async (req: Request, res: Response, next: NextFunction) => {

        const providedMac = req.headers['diskrot-signature'] as string || ''
        const data = req.body;

        if (!req.headers['client-id']) {
            res.status(401).send('Unauthorized');
            return;
        }

        const client = await clientRepository.getById(req.headers['client-id'] as string);

        if (!client) {
            res.status(401).send('Unauthorized');
            return;
        }

        const expectedMac = computeHMAC(
            client,
            {
                url: req.baseUrl,
                payload: data
            });

        if (providedMac !== expectedMac) {
            console.error(`Unauthorized ${providedMac} !== ${expectedMac}`);
            res.status(401).send('Unauthorized');
            return;
        }

        next();
    }
}

function createDigestString(client: Client, data: RequestData): string {
    return `${client.id}|${data.url}|${JSON.stringify(data.payload)}`;
}

function computeHMAC(client: Client, data: RequestData): string {
    const digestString = createDigestString(client, data);

    // @ts-ignore
    const digest = crypto.createHmac('sha256', client.sharedSecret)
        .update(digestString)
        .digest('hex');

    return digest;
}

interface RequestData {
    url: string;
    payload: any;
}