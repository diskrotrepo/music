import 'package:music_app/database/database.dart';
import 'package:logger/logger.dart';
import 'package:music_app/database/tables.drift.dart';
import 'package:music_app/dependency_context.dart';

class CreateRepository {
  CreateRepository({required AppDatabase database}) : _database = database;
  final AppDatabase _database;
  final Logger _logger = di.get<Logger>();

  Future<void> createSong({
    required String id,
    required String title,
    required String styles,
    required String lyrics,
    required int duration,
    required int steps,
    required int cfgStrength,
    required String lyricsPrompt,
    String? negativeTags,
    String? inputFile,
  }) async {
    await _database.into(_database.music).insert(
          MusicCompanion.insert(
            id: id,
            title: title,
            tags: styles,
            negativeTags: negativeTags ?? '',
            lyrics: lyrics,
            duration: duration,
            steps: steps,
            cfgStrength: cfgStrength,
            lrcPrompt: lyricsPrompt,
            inputFile: inputFile ?? '',
            isDeleted: false,
            model: '',
            processingStatus: 'NEW',
            clientProcessingId: 'remote',
            isFavorite: false,
          ),
        );

    _logger.i("New music created with ID: $id");
  }
}
