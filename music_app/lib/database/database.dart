import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:music_app/database/tables.dart';
import 'package:path/path.dart' as p;
import 'package:music_app/database/database.drift.dart';
import 'package:path_provider/path_provider.dart';

@DriftDatabase(
  tables: [
    Music,
    Prompt,
    Client,
    Invitations,
    Connections,
    Settings,
    Queue,
  ],
)
class AppDatabase extends $AppDatabase {
  AppDatabase() : super(_openDatabase());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
    );
  }
}

LazyDatabase _openDatabase() {
  return LazyDatabase(() async {
    final file = File(p.join('diskrot.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}
