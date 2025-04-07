import 'dart:async';

import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:music_app/database/database.dart';
import 'package:music_app/dependency_context.dart';
import 'package:music_app/networking/diskrot_network.dart';
import 'package:music_app/settings/settings_repository.dart';

// Fetching more work to do
Future<void> diskRotBackgroundWorker(int timer) async {
  setup();
  final database = di.get<AppDatabase>();
  final logger = di.get<Logger>();
  final settingsRepository = di.get<SettingsRepository>();

  Timer.periodic(const Duration(seconds: 1), (Timer t) async {
    final query = database.select(database.queue);
    query.where((tbl) => tbl.processingStatus.equals("IN-PROGRESS"));

    final results = await query.getSingleOrNull();

    if (results != null) {
      logger.i(
          "Diskrot Inference Dispatch: already working on a task, skipping this cycle.");
      return;
    }

    logger.i("Diskrot Inference Dispatch: request work.");

    final result = await get("/queue/next");
  });

  // Checking status of existing work
  Timer.periodic(const Duration(seconds: 1), (Timer t) async {
    final query = database.select(database.queue);
    query.where((tbl) => tbl.processingStatus.equals("IN-PROGRESS"));

    final results = await query.getSingleOrNull();

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
