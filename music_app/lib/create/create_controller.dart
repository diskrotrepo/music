/*generate = async (req: Request, res: Response): Promise<void> => {
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:music_app/create/create_repository.dart';
import 'package:music_app/dependency_context.dart';
import 'package:music_app/networking/diskrot_network.dart';
import 'package:music_app/settings/settings_repository.dart';

class CreateController extends ChangeNotifier {
  CreateController({
    required this.createRepository,
    required this.settingsRepository,
  });
  final CreateRepository createRepository;
  final SettingsRepository settingsRepository;
  final Logger _logger = di.get<Logger>();

  Future<void> createSong({
    required String title,
    required String styles,
    required String lyrics,
    required int duration,
    required int cfgStrength,
    required int steps,
  }) async {
    _logger.i("Creating song...");

    final isLocal = await isRunningLocally();
    final lrcPrompt = await settingsRepository.getPromptSettings();

    late String songId;

    if (isLocal) {
      throw Exception("Local generation is not supported yet.");
    } else {
      _logger.i('Submitting task to diskrot network');
      songId = await submitTask(
        title: title,
        tags: styles,
        lyrics: lyrics,
        duration: duration,
        cfgStrength: cfgStrength,
        steps: steps,
        lyricsPrompt: lrcPrompt,
        negativeTags: '',
        inputFile: '',
      );
    }

    await createRepository.createSong(
      id: songId,
      title: title,
      styles: styles,
      lyrics: lyrics,
      duration: duration,
      cfgStrength: cfgStrength,
      lyricsPrompt: lrcPrompt,
      steps: steps,
    );
  }

  Future<String> submitTask({
    required String title,
    required String tags,
    required String lyrics,
    required int duration,
    required int cfgStrength,
    required int steps,
    required String lyricsPrompt,
    required String negativeTags,
    required String inputFile,
  }) async {
    final response = await post(
        "/queue",
        jsonEncode({
          "lyrics": lyrics,
          "duration": duration,
          "steps": steps,
          "title": title,
          "cfg_strength": cfgStrength,
          "tags": tags,
          "lrc_prompt": lyricsPrompt,
          "lrc_model": '',
          "negative_tags": negativeTags,
        }));

    if (response.statusCode != 200) {
      _logger.e("Failed to submit task: ${response.body}");
      throw Exception("Failed to submit task");
    }
    final submitTaskResponse = jsonDecode(response.body);

    return submitTaskResponse["id"];
  }

  Future<bool> isRunningLocally() async {
    /*
        const connectionsCheck = SELECT count(*) as connections FROM connections`;
        const result: { connections: number } = db.prepare(connectionsCheck).get() as { connections: number };
        return result.connections === 0;*/

    return false;
  }
}
