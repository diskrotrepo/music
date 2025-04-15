import 'package:drift/drift.dart';
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
    required bool isLocal,
    String? negativeTags,
    String? inputFile,
  }) async {
    await _database.into(_database.music).insert(
          MusicCompanion.insert(
            id: id,
            title: title,
            tags: styles,
            negativeTags: Value(negativeTags),
            lyrics: Value(lyrics),
            duration: duration,
            steps: steps,
            cfgStrength: cfgStrength,
            lrcPrompt: lyricsPrompt,
            inputFile: Value(inputFile),
            isDeleted: false,
            model: Value(''),
            processingStatus: 'NEW',
            clientProcessingId: isLocal ? 'local' : 'remote',
            isFavorite: false,
          ),
        );

    _logger.i("New music created with ID: $id");
  }

  Future<Music> getNext() async {
    return await _database.select(_database.music)
      ..where((tbl) => tbl.processingStatus.equals('NEW'))
      ..orderBy([
        OrderingTerm.desc(_database.music.createdAt),
      ])
      ..limit(1)
      ..getSingle();
  }
}
