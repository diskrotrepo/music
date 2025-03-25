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


export class DiskrotNetworkClient {
    private static _diskrotNetwork: DiskrotNetwork = null;

    static get diskrotNetworkClient(): DiskrotNetwork {

        if (!DiskrotNetworkClient._diskrotNetwork) {

            try {
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
            } catch (error) {
                console.error("Error initializing diskrot client", error);
            }


        }

        return DiskrotNetworkClient._diskrotNetwork;
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

    if (!DiskrotNetworkClient.diskrotNetworkClient) {
        return;
    }

    const client = DiskrotNetworkClient.diskrotNetworkClient.getClient();

    try {
        let workItems = await DiskrotNetworkClient.diskrotNetworkClient.get(`/queue`);

        if (!workItems || workItems.queue.length === 0) {
            console.log("fetchData: No work items available on the diskrot network");
            return;
        }

        for (let i: number = 0; i < workItems.queue.length; i++) {

            let work = workItems.queue[i];

            db.prepare("INSERT INTO queue (id, title, lyrics, tags, negative_tags, steps, cfg_strength, duration, client_requested_id, lrc_prompt) VALUES (?,?,?,?,?,?,?,?,?,?)").run(
                [
                    work.data.music_id,
                    work.data.title,
                    work.data.lyrics,
                    work.data.tags,
                    work.data.negative_tags,
                    work.data.steps,
                    work.data.cfg_strength,
                    work.data.duration,
                    work.data.client_id,
                    work.data.lrc_prompt
                ]
            );

            console.log(work);
        }

    } catch (error) {
        console.error(error);

    }
}

(async () => {
    try {
        await poll(fetchData, 2000);
    } catch (err) {
        console.error("Polling for work stopped unexpectedly:", err);
    }
})();

async function submitWork(): Promise<void> {

    if (!DiskrotNetworkClient.diskrotNetworkClient) {
        return;
    }

    const client = DiskrotNetworkClient.diskrotNetworkClient.getClient();

    try {
        let inProgressWork = db.prepare("SELECT * FROM queue WHERE processing_status = 'IN-PROGRESS'").get();

        if (inProgressWork) {
            console.log("submitWork: Waiting for inference server to complete work");
            return;
        }

        let workItem = db.prepare("SELECT * FROM queue WHERE processing_status = 'NEW' ORDER BY dt_created ASC LIMIT 1").get() as { id: string, title: string, lyrics: string, tags: string, negative_tags: string, steps: number, cfg_strength: number, duration: number, client_requested_id: string, lrc_prompt: string };

        if (!workItem) {
            console.log("submitWork: There is no available work to submit for the inference server");
            return;
        }

        console.log(workItem);

        const endpoint = "/task";

        const query = `SELECT * FROM settings WHERE key in ('inference_hostname', 'inference_port', 'inference_queue_size')`;
        const result = db.prepare(query).all() as { key: string, value: string }[];

        let inferenceServer = {
            "hostname": result.find((r) => r.key === 'inference_hostname')?.value,
            "port": Number.parseInt(result.find((r) => r.key === 'inference_port')?.value).toFixed(0),
            "maxQueueSize": Number.parseInt(result.find((r) => r.key === 'inference_queue_size')?.value).toFixed(0)
        }

        const submitTaskUrl = `${inferenceServer.hostname}:${inferenceServer.port}${endpoint}`;

        console.info(`submitWork: Submitting task to ${submitTaskUrl}`);

        let task = {
            title: workItem.title,
            lyrics: workItem.lyrics,
            tags: workItem.tags,
            negative_prompt: workItem.negative_tags,
            // input_file: workItem.input,
            duration: workItem.duration,
            steps: workItem.steps,
            lrc_prompt: workItem.lrc_prompt,
            //   lrc_model: workItem.lrc_model,
            cfg_strength: workItem.cfg_strength
        }

        console.log(task);


        const response = await fetch(submitTaskUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(task)
        });

        if (!response.ok) {
            console.error(response);
            return;
        }

        const data = await response.json();

        console.log(data);



        db.prepare("UPDATE queue SET processing_status = 'IN-PROGRESS', dt_started = CURRENT_TIMESTAMP, queued_work_id = ? WHERE id = ?").run([
            data.id,
            workItem.id
        ]);


    } catch (error) {
        console.error(error);

    }
}

(async () => {
    try {
        await poll(submitWork, 2000);
    } catch (err) {
        console.error("Sending work stopped unexpectedly:", err);
    }
})();


async function getInferenceProgress(): Promise<void> {

    if (!DiskrotNetworkClient.diskrotNetworkClient) {
        return;
    }

    const client = DiskrotNetworkClient.diskrotNetworkClient.getClient();

    try {
        let inProgressWork = db.prepare("SELECT queued_work_id FROM queue WHERE processing_status = 'IN-PROGRESS'").get() as { queued_work_id: string };

        if (!inProgressWork) {
            console.log("getInferenceProgress: There is no work in progress on the inference server");
            return;
        }

        const endpoint = "api/v1/queue";

        const query = `SELECT * FROM settings WHERE key in ('inference_hostname', 'inference_port', 'inference_queue_size')`;
        const result = db.prepare(query).all() as { key: string, value: string }[];

        let inferenceServer = {
            "hostname": result.find((r) => r.key === 'inference_hostname')?.value,
            "port": Number.parseInt(result.find((r) => r.key === 'inference_port')?.value).toFixed(0),
            "maxQueueSize": Number.parseInt(result.find((r) => r.key === 'inference_queue_size')?.value).toFixed(0)
        }

        const inferenceStatusUrl = `${inferenceServer.hostname}:${inferenceServer.port}${endpoint}/${inProgressWork.queued_work_id}`;

        console.info(`getInferenceProgress: Checking for task on ${inferenceStatusUrl}`);

        try {
            const response = await fetch(inferenceStatusUrl);

            if (!response.ok) {

                if (response.status === 404) {
                    console.log(`getInferenceProgress: Inference server has no record of the task: ${inProgressWork.queued_work_id}`);
                    /*
                     db.prepare("UPDATE queue SET processing_status = 'FAILED', dt_completed = CURRENT_TIMESTAMP WHERE queued_work_id = ?").run([
                         inProgressWork.queued_work_id
                     ]);*/
                    db.prepare("UPDATE queue SET processing_status = 'FAILED' WHERE queued_work_id = ?").run([
                        inProgressWork.queued_work_id
                    ]);
                }

                return;
            }

            const data = await response.json();

            if (data.processing_status === 'COMPLETE') {

                // Update Network
                const networkResponse = await DiskrotNetworkClient.diskrotNetworkClient.post(`/queue/${inProgressWork.id}/complete`, {});

                if (!networkResponse) {
                    console.error("Unable to update diskrot network");
                    return;
                }

                // Update local database
                db.prepare("UPDATE queue SET processing_status = 'COMPLETE' WHERE queued_work_id = ?").run([
                    inProgressWork.queued_work_id
                ]);


                // Remove job from inference server
                const response = await fetch(inferenceStatusUrl, {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json',
                    }
                });

                console.log(response);
                // Music deletes task
            }

            console.log(response);
        } catch (error) {
            console.error('Unable to communicate with the diskrot network.');
        }




    } catch (error) {
        console.error(error);

    }
}

(async () => {
    try {
        await poll(getInferenceProgress, 2000);
    } catch (err) {
        console.error("Polling for inference work:", err);
    }
})();