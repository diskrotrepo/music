import 'package:music_app/database/database.dart';
import 'package:logger/logger.dart';
import 'package:music_app/dependency_context.dart';

class CreateRepository {
  CreateRepository({required AppDatabase database}) : _database = database;
  final AppDatabase _database;
  final Logger _logger = di.get<Logger>();

  /*
    generate = async (req: Request, res: Response): Promise<void> => {
        const data = req.body || {};
        let submitTaskResponse = null;
        const isLocal = this.isRunningLocally();

        const promptQuery = `
        SELECT * FROM prompt 
        WHERE is_default = 1 AND category = ? 
        LIMIT 1
        `;

        const lrcPromptResult: Prompt | undefined = db.prepare(promptQuery).get("LRC") as Prompt;

        if (isLocal) {
            console.log("Running locally");
            submitTaskResponse = await this.localGenerate(data, lrcPromptResult);
        } else {
            console.log("Submitting task to diskrot network");
            submitTaskResponse = await this.submitTask(data, lrcPromptResult);
        }

        console.log(submitTaskResponse);

        const newMusicQuery = `
        INSERT INTO music (
            id, filename, title, lyrics, tags, client_processing_id, lrc_prompt,
            lrc_model, negative_tags, input_file, duration, steps, cfg_strength, model, dt_created
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
        `;
        db.prepare(newMusicQuery).run(
            submitTaskResponse.id,
            "not available",
            data.title,
            data.lyrics,
            data.tags,
            isLocal ? "remote" : "local",
            lrcPromptResult.prompt,
            lrcPromptResult.model,
            data.negative_tags,
            data.input,
            data.duration,
            data.steps,
            data.cfg_strength,
            "unknown"
        );

        res.json({ id: submitTaskResponse.id });

    }

    isRunningLocally = (): boolean => {
        const connectionsCheck = ` SELECT count(*) as connections FROM connections`;
        const result: { connections: number } = db.prepare(connectionsCheck).get() as { connections: number };
        return result.connections === 0;
    }

    async submitTask(data: any, prompt: Prompt): Promise<any> {

        const response = await this.diskrotNetwork.post("/queue", {
            lyrics: data.lyrics,
            duration: data.duration,
            steps: data.steps,
            title: data.title,
            cfg_strength: data.cfg_strength,
            tags: data.tags,
            lrc_prompt: prompt.prompt,
            lrc_model: prompt.model,
            negative_tags: data.negative_tags,
        });


        return response;
    }

    localGenerate = async (data: any, prompt: Prompt): Promise<any> => {





        //  const submitTaskResponse: { id: string } = { id: "yup" }

        return "";

    }
  */
}
