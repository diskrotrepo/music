

export class EmailService {

    sendEmail = async (email: string, subject: string, body: string): Promise<void> => {
        console.log(`Sending email to ${email} with subject ${subject} and body ${body}`);
    }
}