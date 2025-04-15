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

    if (!isLocal) {
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
      isLocal: isLocal,
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
    final settings = await settingsRepository.getGpuSettings();
    final hostname = settings.hostname;

    return hostname == "127.0.0.1";
  }
}
