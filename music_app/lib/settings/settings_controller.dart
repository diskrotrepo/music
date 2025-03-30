import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_app/settings/settings_repository.dart';
import 'package:http/http.dart' as http;

class SettingsController extends ChangeNotifier {
  SettingsController({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository;

  final SettingsRepository _settingsRepository;

  Future<void> updateGPUSettings({
    required String hostname,
    required String port,
    required String maxQueueSize,
  }) async {
    _settingsRepository.updateGPUSettings(hostname, port, maxQueueSize);
    notifyListeners();
  }

  void updatePromptsSettings(String promptText) {
    _settingsRepository.updatePromptsSettings(promptText);
    notifyListeners();
  }

  void updateSharingSettings(bool sharingEnabled, String nickname) {
    _settingsRepository.updateNetworkSettings(sharingEnabled);

    final url = "http://127.0.0.1:8080/api/v1/registration/client";

    http
        .post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "nickname": nickname,
        },
      ),
    )
        .then((response) {
      if (response.statusCode == 200) {
        print('Registration successful');
      } else {
        print('Registration failed: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Error: $error');
    });

    notifyListeners();
  }

  /*

  async register(req: Request, res: Response): Promise<void> {

        const data = req.body || {};


        let fullUrl = configuration.diskrot.secure == true ? "https://" : "http://";
        fullUrl += configuration.diskrot.hostname + ":" + configuration.diskrot.port;
        fullUrl += configuration.diskrot.api + "/registration/client";

        const response = await fetch(
            fullUrl,
            {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            }
        );

        const ClientRegistrationResponse = await response.json() as ClientRegistrationResponse;

        const query = `
        INSERT INTO client (id, nickname, shared_secret)
        VALUES (?, ?, ?)
        `;

        db.prepare(query).run([
            ClientRegistrationResponse.client.id,
            ClientRegistrationResponse.client.nickname,
            ClientRegistrationResponse.client.sharedSecret
        ]);

        res.json({ "id": ClientRegistrationResponse.client.id });

    }
    */

  Future<GpuSettings> getGpuSettings() async {
    return await _settingsRepository.getGpuSettings();
  }

  Future<String> getPromptSettings() async {
    return await _settingsRepository.getPromptSettings();
  }

  Future<String?> getNetworkSettings() async {
    final enabled = await _settingsRepository.getNetworkSettings();

    return enabled ? 'alexayers' : null;
  }
}
