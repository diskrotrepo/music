import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:music_app/configuration/configuration.dart';
import 'package:music_app/dependency_context.dart';
import 'package:music_app/network/network_repository.dart';
import 'package:music_app/settings/settings_repository.dart';
import 'package:http/http.dart' as http;

class SettingsController extends ChangeNotifier {
  SettingsController({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  final SettingsRepository _settingsRepository;
  final Logger _logger = di.get<Logger>();

  Future<bool> updateGPUSettings({
    required String hostname,
    required String port,
    required String maxQueueSize,
  }) async {
    final results = await _settingsRepository.updateGPUSettings(
        hostname, port, maxQueueSize);
    notifyListeners();
    return results;
  }

  void updatePromptsSettings(String promptText) {
    _settingsRepository.updatePromptsSettings(promptText);
    notifyListeners();
  }

  void updateSharingSettings(bool sharingEnabled, String nickname) {
    final configuration = Configuration.fromEnvironment();

    http
        .post(
      Uri.parse(
          "${configuration.serverConfiguration.fullUrl}/registration/client"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "nickname": nickname,
        },
      ),
    )
        .then((response) {
      if (response.statusCode == 200) {
        final file = File('.diskrot_client.json');
        file.writeAsStringSync(response.body);
        _settingsRepository.updateNetworkSettings(true);
        _logger.i('Registration successful: ${response.body}');
      } else {
        _logger.i('Registration failed: ${response.statusCode}');
      }
    }).catchError((error) {
      _logger.e('Error: $error');
    });

    notifyListeners();
  }

  Future<GpuSettings> getGpuSettings() async {
    return await _settingsRepository.getGpuSettings();
  }

  Future<String> getPromptSettings() async {
    return await _settingsRepository.getPromptSettings();
  }

  Future<String?> getNetworkSettings() async {
    final enabled = await _settingsRepository.getNetworkSettings();

    _logger.i('Network settings: $enabled');

    if (enabled == false) {
      return null;
    }

    final file = File('.diskrot_client.json');
    if (file.existsSync() == false) {
      return null;
    }
    final contents = file.readAsStringSync();
    final data = jsonDecode(contents);
    final nickname = data['client']['nickname'] as String;

    return nickname;
  }
}
