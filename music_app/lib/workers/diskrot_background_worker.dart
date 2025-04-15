import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:music_app/create/create_repository.dart';
import 'package:music_app/dependency_context.dart';
import 'package:music_app/network/network_models.dart';
import 'package:music_app/networking/diskrot_network.dart';
import 'package:music_app/settings/settings_repository.dart';

String? inferenceQueueId;

// Fetching more remote work to do
Future<void> diskRotRemoteBackgroundWorker(int timer) async {
  setup();
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

      inferenceQueueId = workItem.music.id;

      logger.i(
          "Diskrot Inference Dispatch: Found work item ${workItem.id}, starting processing.");

      final gpuSettings = await settingsRepository.getGpuSettings();

      final inferenceServer =
          'http://${gpuSettings.hostname}:${gpuSettings.port}/task';

      logger.i(workItem);

      final diskRotClient = di.get<DiskrotClient>();

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
              'shared_secret': diskRotClient.sharedSecret,
              'requesting_client_id': diskRotClient.id,
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
}

Future<void> diskRotLocalBackgroundWorker(int timer) async {
  setup();
  final logger = di.get<Logger>();
  final settingsRepository = di.get<SettingsRepository>();
  final createRepository = di.get<CreateRepository>();

  Timer.periodic(const Duration(seconds: 5), (Timer t) async {
    try {
      final settings = await settingsRepository.getGpuSettings();
      final hostname = settings.hostname;

      if (hostname != "127.0.0.1") {
        logger.i('Diskrot Inference is not dispatching locally.');
        return;
      }

      final workItem = await createRepository.getNext();

      inferenceQueueId = workItem.id;

      logger.i(
          "Diskrot Inference Dispatch: Found work item ${workItem.id}, starting processing.");

      final gpuSettings = await settingsRepository.getGpuSettings();

      final inferenceServer =
          'http://${gpuSettings.hostname}:${gpuSettings.port}/task';

      logger.i(workItem);

      final diskRotClient = di.get<DiskrotClient>();

      try {
        await http.post(Uri.parse(inferenceServer),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'id': workItem.id,
              'tags': workItem.tags,
              'negative_tags': workItem.negativeTags,
              'model': 'unknown',
              'input': '',
              'lrc_model': '',
              'lrc_prompt': workItem.lrcPrompt,
              'lyrics': workItem.lyrics,
              'duration': workItem.duration,
              'cfg_strength': workItem.cfgStrength,
              'steps': workItem.steps,
              'title': workItem.title,
              'client_id': 'local',
              'music_id': workItem.id,
              'shared_secret': 'local',
              'requesting_client_id': diskRotClient.id,
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
}
