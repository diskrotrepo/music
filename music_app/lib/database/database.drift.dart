// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:music_app/database/tables.drift.dart' as i1;

abstract class $AppDatabase extends i0.GeneratedDatabase {
  $AppDatabase(i0.QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final i1.$MusicTable music = i1.$MusicTable(this);
  late final i1.$PromptTable prompt = i1.$PromptTable(this);
  late final i1.$ClientTable client = i1.$ClientTable(this);
  late final i1.$InvitationsTable invitations = i1.$InvitationsTable(this);
  late final i1.$ConnectionsTable connections = i1.$ConnectionsTable(this);
  late final i1.$SettingsTable settings = i1.$SettingsTable(this);
  late final i1.$QueueTable queue = i1.$QueueTable(this);
  @override
  Iterable<i0.TableInfo<i0.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<i0.TableInfo<i0.Table, Object?>>();
  @override
  List<i0.DatabaseSchemaEntity> get allSchemaEntities =>
      [music, prompt, client, invitations, connections, settings, queue];
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
  i1.$$ClientTableTableManager get client =>
      i1.$$ClientTableTableManager(_db, _db.client);
  i1.$$InvitationsTableTableManager get invitations =>
      i1.$$InvitationsTableTableManager(_db, _db.invitations);
  i1.$$ConnectionsTableTableManager get connections =>
      i1.$$ConnectionsTableTableManager(_db, _db.connections);
  i1.$$SettingsTableTableManager get settings =>
      i1.$$SettingsTableTableManager(_db, _db.settings);
  i1.$$QueueTableTableManager get queue =>
      i1.$$QueueTableTableManager(_db, _db.queue);
}
