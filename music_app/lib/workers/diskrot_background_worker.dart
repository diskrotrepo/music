import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:music_app/database/database.dart';
import 'package:music_app/database/tables.drift.dart';
import 'package:music_app/dependency_context.dart';
import 'package:music_app/network/network_models.dart';
import 'package:music_app/networking/diskrot_network.dart';
import 'package:music_app/settings/settings_repository.dart';

// Fetching more work to do
Future<void> diskRotBackgroundWorker(int timer) async {
  setup();
  final database = di.get<AppDatabase>();
  final logger = di.get<Logger>();
  final settingsRepository = di.get<SettingsRepository>();

  Timer.periodic(const Duration(seconds: 5), (Timer t) async {
    try {
      final getQueuedWorkResponse = await get("/queue/next");

      if (getQueuedWorkResponse.statusCode != 200) {
        logger.i('Diskrot Inference is already working on a task.');
        return;
      }

      final queueResponse =
          QueueResponse.fromJson(jsonDecode(getQueuedWorkResponse.body));

      if (queueResponse.workQueues.isEmpty) {
        logger.i("Diskrot Inference Dispatch: No work items available.");
        return;
      }

      final workItem = queueResponse.workQueues[0];

      logger.i(
          "Diskrot Inference Dispatch: Found work item ${workItem.id}, starting processing.");

      final gpuSettings = await settingsRepository.getGpuSettings();

      final inferenceServer =
          'http://${gpuSettings.hostname}:${gpuSettings.port}/task';

      logger.i(workItem);

      try {
        await http.post(Uri.parse(inferenceServer),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'id': workItem.id,
              'tags': workItem.music.tags,
              'negative_tags': workItem.music.negativeTags,
              'model': 'unknown',
              'input': '',
              'lrc_model': workItem.music.lrcModel,
              'lrc_prompt': workItem.music.lrcPrompt,
              'lyrics': workItem.music.lyrics,
              'duration': workItem.music.duration,
              'cfg_strength': workItem.music.cfgStregth,
              'steps': workItem.music.steps,
              'title': workItem.music.title,
              'client_id': workItem.clientId,
              'music_id': workItem.music.id,
            }));
      } catch (e) {
        logger.e(
            "Diskrot Inference Dispatch: Failed to send task to inference server: $e");
        return;
      }
    } catch (e) {
      logger
          .e("Diskrot Inference Dispatch: Failed to fetch next work item: $e");
      return;
    }
  });

  // Checking status of existing work
  Timer.periodic(const Duration(seconds: 5), (Timer t) async {
    final gpuSettings = await settingsRepository.getGpuSettings();

    final inferenceServer =
        'http://${gpuSettings.hostname}:${gpuSettings.port}/api/v1/queue';

    logger.i(inferenceServer);

    late http.Response queueStatusResponse;
    try {
      queueStatusResponse =
          await http.get(Uri.parse(inferenceServer), headers: {
        'Content-Type': 'application/json',
      });
    } catch (e) {
      logger.e(
          "Diskrot Inference Status Worker: Failed to connect to inference server: $e");
      return;
    }

    if (queueStatusResponse.statusCode == 404) {
      logger.e("Diskrot Inference Status Worker: in an inconsistent state.");

      return;
    }
  });
}
