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

  Timer.periodic(const Duration(seconds: 60), (Timer t) async {
    final query = database.select(database.queue);
    query.where((tbl) => tbl.processingStatus.equals("IN-PROGRESS"));

    final results = await query.getSingleOrNull();

    if (results != null) {
      logger.i(
          "Diskrot Inference Dispatch: already working on a task, skipping this cycle.");
      return;
    }

    logger.i("Diskrot Inference Dispatch: request work.");

    try {
      final getQueuedWorkResponse = await get("/queue/next");

      if (getQueuedWorkResponse.statusCode != 200) {
        logger.e(
            "Diskrot Inference Dispatch: Failed to fetch next work item, status code: ${getQueuedWorkResponse.statusCode}");
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

      await database.queue.insertOne(QueueCompanion(
        id: Value(workItem.id),
        processingStatus: Value("IN-PROGRESS"),
        createdAt: Value(DateTime.now()),
        tags: Value(workItem.music.tags),
        negativeTags: Value(workItem.music.negativeTags),
        model: Value('unknown'),
        inputFile: Value(''),
        lrcPrompt: Value(workItem.music.lrcPrompt),
        lyrics: Value(workItem.music.lyrics),
        duration: Value(workItem.music.duration),
        cfgStrength: Value(workItem.music.cfgStregth),
        steps: Value(workItem.music.steps),
        title: Value(workItem.music.title),
        clientRequestedId: Value(workItem.clientId),
      ));
    } catch (e) {
      logger
          .e("Diskrot Inference Dispatch: Failed to fetch next work item: $e");
      return;
    }
  });

  // Checking status of existing work
  Timer.periodic(const Duration(seconds: 60), (Timer t) async {
    final query = database.select(database.queue);
    query.where((tbl) => tbl.processingStatus.equals("IN-PROGRESS"));

    final results = await query.getSingleOrNull();

    // Sanity check we aren't in an inconsistent state
    if (results == null) {
      logger.i("Diskrot Inference Status Worker: nothing in progress.");

      return;
    }

    final gpuSettings = await settingsRepository.getGpuSettings();

    final inferenceServer =
        'http://${gpuSettings.hostname}:${gpuSettings.port}/api/v1/status/health';

    late http.Response inferenceHealthCheck;
    try {
      inferenceHealthCheck =
          await http.get(Uri.parse(inferenceServer), headers: {
        'Content-Type': 'application/json',
      });
    } catch (e) {
      logger.e(
          "Diskrot Inference Status Worker: Failed to connect to inference server: $e");
      return;
    }

    if (inferenceHealthCheck.statusCode != 200) {
      logger.e(
          "Diskrot Inference Status Worker: Unable to communicate with inference server.");
      return;
    }
  });
}
