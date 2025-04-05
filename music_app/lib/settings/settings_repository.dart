import 'dart:math';

import 'package:drift/drift.dart';
import 'package:music_app/database/database.dart';
import 'package:music_app/database/tables.drift.dart';
import 'package:logger/logger.dart';
import 'package:music_app/dependency_context.dart';
import 'package:http/http.dart' as http;

class SettingsRepository {
  SettingsRepository({required AppDatabase database}) : _database = database;
  final AppDatabase _database;
  final Logger _logger = di.get<Logger>();

  Future<bool> updateGPUSettings(
      String hostname, String port, String maxQueueSize) async {
    final url = "http://$hostname:$port/api/v1/status/health";

    _logger.i('Checking GPU server status at $url');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        await _database.into(_database.settings).insertOnConflictUpdate(
              SettingsCompanion(
                key: const Value('hostname'),
                value: Value(hostname),
              ),
            );

        await _database.into(_database.settings).insertOnConflictUpdate(
              SettingsCompanion(
                key: const Value('port'),
                value: Value(port),
              ),
            );

        await _database.into(_database.settings).insertOnConflictUpdate(
              SettingsCompanion(
                key: const Value('max_queue_size'),
                value: Value(maxQueueSize),
              ),
            );

        return true;
      } else {
        _logger.i('Unable to reach inference server: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _logger.e('Error: $e');
      return false;
    }
  }

  Future<void> updatePromptsSettings(String lrcPrompt) async {
    await _database.into(_database.settings).insertOnConflictUpdate(
          SettingsCompanion(
            key: const Value('lrc_prompt'),
            value: Value(lrcPrompt),
          ),
        );
  }

  Future<void> updateNetworkSettings(bool enabled) async {
    await _database.into(_database.settings).insertOnConflictUpdate(
          SettingsCompanion(
            key: const Value('enable_sharing'),
            value: Value(enabled.toString()),
          ),
        );
  }

  Future<GpuSettings> getGpuSettings() async {
    final settings = await _database.select(_database.settings).get();

    if (settings.isEmpty) {
      return GpuSettings(
        hostname: '127.0.0.1',
        port: '5001',
        maxQueueSize: '20',
      );
    }

    final gpuSettings = settings
        .where((setting) =>
            setting.key == 'hostname' ||
            setting.key == 'port' ||
            setting.key == 'max_queue_size')
        .map((setting) => MapEntry(setting.key, setting.value))
        .toList();

    if (gpuSettings.length < 3) {
      return GpuSettings(
        hostname: '127.0.0.1',
        port: '5001',
        maxQueueSize: '20',
      );
    }

    return GpuSettings(
      hostname: gpuSettings.firstWhere((e) => e.key == 'hostname').value,
      port: gpuSettings.firstWhere((e) => e.key == 'port').value,
      maxQueueSize:
          gpuSettings.firstWhere((e) => e.key == 'max_queue_size').value,
    );
  }

  Future<String> getPromptSettings() async {
    final query = _database.select(_database.settings);
    query.where((tbl) => tbl.key.equals('lrc_prompt'));
    final settings = await query.getSingleOrNull();

    if (settings == null) {
      return 'You are a music player. You can play any song. '
          'You can also generate lyrics for the song. '
          'You can also generate a lrc file for the song.';
    }

    return settings.value;
  }

  Future<bool> getNetworkSettings() async {
    final query = _database.select(_database.settings);
    query.where((tbl) => tbl.key.equals('enable_sharing'));
    final settings = await query.get();

    if (settings.isEmpty) {
      return false;
    }

    return settings.first.value.toLowerCase() == 'true';
  }
}

class GpuSettings {
  GpuSettings({
    required this.hostname,
    required this.port,
    required this.maxQueueSize,
  });

  final String hostname;
  final String port;
  final String maxQueueSize;

  @override
  String toString() {
    return 'GpuSettings(hostname: $hostname, port: $port, maxQueueSize: $maxQueueSize)';
  }
}
