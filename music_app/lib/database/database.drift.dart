// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:music_app/database/tables.drift.dart' as i1;

abstract class $AppDatabase extends i0.GeneratedDatabase {
  $AppDatabase(i0.QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final i1.$MusicTable music = i1.$MusicTable(this);
  late final i1.$PromptTable prompt = i1.$PromptTable(this);
  late final i1.$InvitationTable invitation = i1.$InvitationTable(this);
  late final i1.$NetworkTable network = i1.$NetworkTable(this);
  late final i1.$SettingsTable settings = i1.$SettingsTable(this);
  late final i1.$QueueTable queue = i1.$QueueTable(this);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities =>
      [music, prompt, invitation, network, settings, queue];
  @override
  i0.DriftDatabaseOptions get options =>
      const i0.DriftDatabaseOptions(storeDateTimeAsText: true);
}

class $AppDatabaseManager {
  final $AppDatabase _db;
  $AppDatabaseManager(this._db);
  i1.$$MusicTableTableManager get music =>
      i1.$$MusicTableTableManager(_db, _db.music);
  i1.$$PromptTableTableManager get prompt =>
      i1.$$PromptTableTableManager(_db, _db.prompt);
  i1.$$InvitationTableTableManager get invitation =>
      i1.$$InvitationTableTableManager(_db, _db.invitation);
  i1.$$NetworkTableTableManager get network =>
      i1.$$NetworkTableTableManager(_db, _db.network);
  i1.$$SettingsTableTableManager get settings =>
      i1.$$SettingsTableTableManager(_db, _db.settings);
  i1.$$QueueTableTableManager get queue =>
      i1.$$QueueTableTableManager(_db, _db.queue);
}
