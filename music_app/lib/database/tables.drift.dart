// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:music_app/database/tables.drift.dart' as i1;
import 'package:music_app/database/tables.dart' as i2;
import 'package:drift/src/runtime/query_builder/query_builder.dart' as i3;

typedef $$MusicTableCreateCompanionBuilder = i1.MusicCompanion Function({
  required String id,
  required String title,
  required String lyrics,
  required String tags,
  required String negativeTags,
  required String inputFile,
  required String model,
  required String clientProcessingId,
  required String lrcPrompt,
  required String processingStatus,
  required int steps,
  required int cfgStrength,
  required int duration,
  required bool isFavorite,
  required bool isDeleted,
  i0.Value<DateTime> createdAt,
  i0.Value<int> rowid,
});
typedef $$MusicTableUpdateCompanionBuilder = i1.MusicCompanion Function({
  i0.Value<String> id,
  i0.Value<String> title,
  i0.Value<String> lyrics,
  i0.Value<String> tags,
  i0.Value<String> negativeTags,
  i0.Value<String> inputFile,
  i0.Value<String> model,
  i0.Value<String> clientProcessingId,
  i0.Value<String> lrcPrompt,
  i0.Value<String> processingStatus,
  i0.Value<int> steps,
  i0.Value<int> cfgStrength,
  i0.Value<int> duration,
  i0.Value<bool> isFavorite,
  i0.Value<bool> isDeleted,
  i0.Value<DateTime> createdAt,
  i0.Value<int> rowid,
});

class $$MusicTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$MusicTable> {
  $$MusicTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get lyrics => $composableBuilder(
      column: $table.lyrics, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get negativeTags => $composableBuilder(
      column: $table.negativeTags,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get inputFile => $composableBuilder(
      column: $table.inputFile, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get clientProcessingId => $composableBuilder(
      column: $table.clientProcessingId,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get lrcPrompt => $composableBuilder(
      column: $table.lrcPrompt, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get processingStatus => $composableBuilder(
      column: $table.processingStatus,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<int> get cfgStrength => $composableBuilder(
      column: $table.cfgStrength,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => i0.ColumnFilters(column));
}

class $$MusicTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$MusicTable> {
  $$MusicTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get lyrics => $composableBuilder(
      column: $table.lyrics, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get negativeTags => $composableBuilder(
      column: $table.negativeTags,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get inputFile => $composableBuilder(
      column: $table.inputFile,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get clientProcessingId => $composableBuilder(
      column: $table.clientProcessingId,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get lrcPrompt => $composableBuilder(
      column: $table.lrcPrompt,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get processingStatus => $composableBuilder(
      column: $table.processingStatus,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<int> get cfgStrength => $composableBuilder(
      column: $table.cfgStrength,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => i0.ColumnOrderings(column));
}

class $$MusicTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$MusicTable> {
  $$MusicTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  i0.GeneratedColumn<String> get lyrics =>
      $composableBuilder(column: $table.lyrics, builder: (column) => column);

  i0.GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  i0.GeneratedColumn<String> get negativeTags => $composableBuilder(
      column: $table.negativeTags, builder: (column) => column);

  i0.GeneratedColumn<String> get inputFile =>
      $composableBuilder(column: $table.inputFile, builder: (column) => column);

  i0.GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  i0.GeneratedColumn<String> get clientProcessingId => $composableBuilder(
      column: $table.clientProcessingId, builder: (column) => column);

  i0.GeneratedColumn<String> get lrcPrompt =>
      $composableBuilder(column: $table.lrcPrompt, builder: (column) => column);

  i0.GeneratedColumn<String> get processingStatus => $composableBuilder(
      column: $table.processingStatus, builder: (column) => column);

  i0.GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  i0.GeneratedColumn<int> get cfgStrength => $composableBuilder(
      column: $table.cfgStrength, builder: (column) => column);

  i0.GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  i0.GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  i0.GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MusicTableTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.$MusicTable,
    i1.Music,
    i1.$$MusicTableFilterComposer,
    i1.$$MusicTableOrderingComposer,
    i1.$$MusicTableAnnotationComposer,
    $$MusicTableCreateCompanionBuilder,
    $$MusicTableUpdateCompanionBuilder,
    (
      i1.Music,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$MusicTable, i1.Music>
    ),
    i1.Music,
    i0.PrefetchHooks Function()> {
  $$MusicTableTableManager(i0.GeneratedDatabase db, i1.$MusicTable table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$MusicTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$MusicTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$$MusicTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String> id = const i0.Value.absent(),
            i0.Value<String> title = const i0.Value.absent(),
            i0.Value<String> lyrics = const i0.Value.absent(),
            i0.Value<String> tags = const i0.Value.absent(),
            i0.Value<String> negativeTags = const i0.Value.absent(),
            i0.Value<String> inputFile = const i0.Value.absent(),
            i0.Value<String> model = const i0.Value.absent(),
            i0.Value<String> clientProcessingId = const i0.Value.absent(),
            i0.Value<String> lrcPrompt = const i0.Value.absent(),
            i0.Value<String> processingStatus = const i0.Value.absent(),
            i0.Value<int> steps = const i0.Value.absent(),
            i0.Value<int> cfgStrength = const i0.Value.absent(),
            i0.Value<int> duration = const i0.Value.absent(),
            i0.Value<bool> isFavorite = const i0.Value.absent(),
            i0.Value<bool> isDeleted = const i0.Value.absent(),
            i0.Value<DateTime> createdAt = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.MusicCompanion(
            id: id,
            title: title,
            lyrics: lyrics,
            tags: tags,
            negativeTags: negativeTags,
            inputFile: inputFile,
            model: model,
            clientProcessingId: clientProcessingId,
            lrcPrompt: lrcPrompt,
            processingStatus: processingStatus,
            steps: steps,
            cfgStrength: cfgStrength,
            duration: duration,
            isFavorite: isFavorite,
            isDeleted: isDeleted,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String lyrics,
            required String tags,
            required String negativeTags,
            required String inputFile,
            required String model,
            required String clientProcessingId,
            required String lrcPrompt,
            required String processingStatus,
            required int steps,
            required int cfgStrength,
            required int duration,
            required bool isFavorite,
            required bool isDeleted,
            i0.Value<DateTime> createdAt = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.MusicCompanion.insert(
            id: id,
            title: title,
            lyrics: lyrics,
            tags: tags,
            negativeTags: negativeTags,
            inputFile: inputFile,
            model: model,
            clientProcessingId: clientProcessingId,
            lrcPrompt: lrcPrompt,
            processingStatus: processingStatus,
            steps: steps,
            cfgStrength: cfgStrength,
            duration: duration,
            isFavorite: isFavorite,
            isDeleted: isDeleted,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MusicTableProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.$MusicTable,
    i1.Music,
    i1.$$MusicTableFilterComposer,
    i1.$$MusicTableOrderingComposer,
    i1.$$MusicTableAnnotationComposer,
    $$MusicTableCreateCompanionBuilder,
    $$MusicTableUpdateCompanionBuilder,
    (
      i1.Music,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$MusicTable, i1.Music>
    ),
    i1.Music,
    i0.PrefetchHooks Function()>;
typedef $$PromptTableCreateCompanionBuilder = i1.PromptCompanion Function({
  required String id,
  required String prompt,
  required String category,
  i0.Value<DateTime> createdAt,
  i0.Value<int> rowid,
});
typedef $$PromptTableUpdateCompanionBuilder = i1.PromptCompanion Function({
  i0.Value<String> id,
  i0.Value<String> prompt,
  i0.Value<String> category,
  i0.Value<DateTime> createdAt,
  i0.Value<int> rowid,
});

class $$PromptTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$PromptTable> {
  $$PromptTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get prompt => $composableBuilder(
      column: $table.prompt, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => i0.ColumnFilters(column));
}

class $$PromptTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$PromptTable> {
  $$PromptTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get prompt => $composableBuilder(
      column: $table.prompt, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => i0.ColumnOrderings(column));
}

class $$PromptTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$PromptTable> {
  $$PromptTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get prompt =>
      $composableBuilder(column: $table.prompt, builder: (column) => column);

  i0.GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PromptTableTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.$PromptTable,
    i1.Prompt,
    i1.$$PromptTableFilterComposer,
    i1.$$PromptTableOrderingComposer,
    i1.$$PromptTableAnnotationComposer,
    $$PromptTableCreateCompanionBuilder,
    $$PromptTableUpdateCompanionBuilder,
    (
      i1.Prompt,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$PromptTable, i1.Prompt>
    ),
    i1.Prompt,
    i0.PrefetchHooks Function()> {
  $$PromptTableTableManager(i0.GeneratedDatabase db, i1.$PromptTable table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$PromptTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$PromptTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$$PromptTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String> id = const i0.Value.absent(),
            i0.Value<String> prompt = const i0.Value.absent(),
            i0.Value<String> category = const i0.Value.absent(),
            i0.Value<DateTime> createdAt = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.PromptCompanion(
            id: id,
            prompt: prompt,
            category: category,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String prompt,
            required String category,
            i0.Value<DateTime> createdAt = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.PromptCompanion.insert(
            id: id,
            prompt: prompt,
            category: category,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PromptTableProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.$PromptTable,
    i1.Prompt,
    i1.$$PromptTableFilterComposer,
    i1.$$PromptTableOrderingComposer,
    i1.$$PromptTableAnnotationComposer,
    $$PromptTableCreateCompanionBuilder,
    $$PromptTableUpdateCompanionBuilder,
    (
      i1.Prompt,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$PromptTable, i1.Prompt>
    ),
    i1.Prompt,
    i0.PrefetchHooks Function()>;
typedef $$InvitationsTableCreateCompanionBuilder = i1.InvitationsCompanion
    Function({
  required String id,
  i0.Value<String?> clientAcceptedId,
  required String code,
  i0.Value<DateTime> createdAt,
  i0.Value<int> rowid,
});
typedef $$InvitationsTableUpdateCompanionBuilder = i1.InvitationsCompanion
    Function({
  i0.Value<String> id,
  i0.Value<String?> clientAcceptedId,
  i0.Value<String> code,
  i0.Value<DateTime> createdAt,
  i0.Value<int> rowid,
});

class $$InvitationsTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$InvitationsTable> {
  $$InvitationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get clientAcceptedId => $composableBuilder(
      column: $table.clientAcceptedId,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => i0.ColumnFilters(column));
}

class $$InvitationsTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$InvitationsTable> {
  $$InvitationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get clientAcceptedId => $composableBuilder(
      column: $table.clientAcceptedId,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => i0.ColumnOrderings(column));
}

class $$InvitationsTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$InvitationsTable> {
  $$InvitationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get clientAcceptedId => $composableBuilder(
      column: $table.clientAcceptedId, builder: (column) => column);

  i0.GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$InvitationsTableTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.$InvitationsTable,
    i1.Invitations,
    i1.$$InvitationsTableFilterComposer,
    i1.$$InvitationsTableOrderingComposer,
    i1.$$InvitationsTableAnnotationComposer,
    $$InvitationsTableCreateCompanionBuilder,
    $$InvitationsTableUpdateCompanionBuilder,
    (
      i1.Invitations,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$InvitationsTable,
          i1.Invitations>
    ),
    i1.Invitations,
    i0.PrefetchHooks Function()> {
  $$InvitationsTableTableManager(
      i0.GeneratedDatabase db, i1.$InvitationsTable table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$InvitationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$InvitationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$$InvitationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String> id = const i0.Value.absent(),
            i0.Value<String?> clientAcceptedId = const i0.Value.absent(),
            i0.Value<String> code = const i0.Value.absent(),
            i0.Value<DateTime> createdAt = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.InvitationsCompanion(
            id: id,
            clientAcceptedId: clientAcceptedId,
            code: code,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            i0.Value<String?> clientAcceptedId = const i0.Value.absent(),
            required String code,
            i0.Value<DateTime> createdAt = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.InvitationsCompanion.insert(
            id: id,
            clientAcceptedId: clientAcceptedId,
            code: code,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$InvitationsTableProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.$InvitationsTable,
    i1.Invitations,
    i1.$$InvitationsTableFilterComposer,
    i1.$$InvitationsTableOrderingComposer,
    i1.$$InvitationsTableAnnotationComposer,
    $$InvitationsTableCreateCompanionBuilder,
    $$InvitationsTableUpdateCompanionBuilder,
    (
      i1.Invitations,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$InvitationsTable,
          i1.Invitations>
    ),
    i1.Invitations,
    i0.PrefetchHooks Function()>;
typedef $$ConnectionsTableCreateCompanionBuilder = i1.ConnectionsCompanion
    Function({
  required String id,
  required String nickname,
  required String direction,
  required String clientId,
  i0.Value<DateTime> createdAt,
  i0.Value<int> rowid,
});
typedef $$ConnectionsTableUpdateCompanionBuilder = i1.ConnectionsCompanion
    Function({
  i0.Value<String> id,
  i0.Value<String> nickname,
  i0.Value<String> direction,
  i0.Value<String> clientId,
  i0.Value<DateTime> createdAt,
  i0.Value<int> rowid,
});

class $$ConnectionsTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$ConnectionsTable> {
  $$ConnectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => i0.ColumnFilters(column));
}

class $$ConnectionsTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$ConnectionsTable> {
  $$ConnectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get direction => $composableBuilder(
      column: $table.direction,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => i0.ColumnOrderings(column));
}

class $$ConnectionsTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$ConnectionsTable> {
  $$ConnectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  i0.GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  i0.GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ConnectionsTableTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.$ConnectionsTable,
    i1.Connections,
    i1.$$ConnectionsTableFilterComposer,
    i1.$$ConnectionsTableOrderingComposer,
    i1.$$ConnectionsTableAnnotationComposer,
    $$ConnectionsTableCreateCompanionBuilder,
    $$ConnectionsTableUpdateCompanionBuilder,
    (
      i1.Connections,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$ConnectionsTable,
          i1.Connections>
    ),
    i1.Connections,
    i0.PrefetchHooks Function()> {
  $$ConnectionsTableTableManager(
      i0.GeneratedDatabase db, i1.$ConnectionsTable table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$ConnectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$ConnectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$$ConnectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String> id = const i0.Value.absent(),
            i0.Value<String> nickname = const i0.Value.absent(),
            i0.Value<String> direction = const i0.Value.absent(),
            i0.Value<String> clientId = const i0.Value.absent(),
            i0.Value<DateTime> createdAt = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.ConnectionsCompanion(
            id: id,
            nickname: nickname,
            direction: direction,
            clientId: clientId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nickname,
            required String direction,
            required String clientId,
            i0.Value<DateTime> createdAt = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.ConnectionsCompanion.insert(
            id: id,
            nickname: nickname,
            direction: direction,
            clientId: clientId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ConnectionsTableProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.$ConnectionsTable,
    i1.Connections,
    i1.$$ConnectionsTableFilterComposer,
    i1.$$ConnectionsTableOrderingComposer,
    i1.$$ConnectionsTableAnnotationComposer,
    $$ConnectionsTableCreateCompanionBuilder,
    $$ConnectionsTableUpdateCompanionBuilder,
    (
      i1.Connections,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$ConnectionsTable,
          i1.Connections>
    ),
    i1.Connections,
    i0.PrefetchHooks Function()>;
typedef $$SettingsTableCreateCompanionBuilder = i1.SettingsCompanion Function({
  required String key,
  required String value,
  i0.Value<DateTime> createdAt,
  i0.Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = i1.SettingsCompanion Function({
  i0.Value<String> key,
  i0.Value<String> value,
  i0.Value<DateTime> createdAt,
  i0.Value<int> rowid,
});

class $$SettingsTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => i0.ColumnFilters(column));
}

class $$SettingsTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => i0.ColumnOrderings(column));
}

class $$SettingsTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  i0.GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SettingsTableTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.$SettingsTable,
    i1.Settings,
    i1.$$SettingsTableFilterComposer,
    i1.$$SettingsTableOrderingComposer,
    i1.$$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (
      i1.Settings,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$SettingsTable, i1.Settings>
    ),
    i1.Settings,
    i0.PrefetchHooks Function()> {
  $$SettingsTableTableManager(i0.GeneratedDatabase db, i1.$SettingsTable table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String> key = const i0.Value.absent(),
            i0.Value<String> value = const i0.Value.absent(),
            i0.Value<DateTime> createdAt = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.SettingsCompanion(
            key: key,
            value: value,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            i0.Value<DateTime> createdAt = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.SettingsCompanion.insert(
            key: key,
            value: value,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SettingsTableProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.$SettingsTable,
    i1.Settings,
    i1.$$SettingsTableFilterComposer,
    i1.$$SettingsTableOrderingComposer,
    i1.$$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (
      i1.Settings,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$SettingsTable, i1.Settings>
    ),
    i1.Settings,
    i0.PrefetchHooks Function()>;
typedef $$QueueTableCreateCompanionBuilder = i1.QueueCompanion Function({
  required String id,
  required String title,
  i0.Value<String?> lyrics,
  required String tags,
  i0.Value<String?> negativeTags,
  i0.Value<String?> inputFile,
  required String model,
  required String clientRequestedId,
  required String lrcPrompt,
  required String processingStatus,
  required int steps,
  required int cfgStrength,
  required int duration,
  i0.Value<bool> isFavorite,
  i0.Value<bool> isDeleted,
  i0.Value<DateTime> createdAt,
  i0.Value<int> rowid,
});
typedef $$QueueTableUpdateCompanionBuilder = i1.QueueCompanion Function({
  i0.Value<String> id,
  i0.Value<String> title,
  i0.Value<String?> lyrics,
  i0.Value<String> tags,
  i0.Value<String?> negativeTags,
  i0.Value<String?> inputFile,
  i0.Value<String> model,
  i0.Value<String> clientRequestedId,
  i0.Value<String> lrcPrompt,
  i0.Value<String> processingStatus,
  i0.Value<int> steps,
  i0.Value<int> cfgStrength,
  i0.Value<int> duration,
  i0.Value<bool> isFavorite,
  i0.Value<bool> isDeleted,
  i0.Value<DateTime> createdAt,
  i0.Value<int> rowid,
});

class $$QueueTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$QueueTable> {
  $$QueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get lyrics => $composableBuilder(
      column: $table.lyrics, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get negativeTags => $composableBuilder(
      column: $table.negativeTags,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get inputFile => $composableBuilder(
      column: $table.inputFile, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get clientRequestedId => $composableBuilder(
      column: $table.clientRequestedId,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get lrcPrompt => $composableBuilder(
      column: $table.lrcPrompt, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<String> get processingStatus => $composableBuilder(
      column: $table.processingStatus,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<int> get cfgStrength => $composableBuilder(
      column: $table.cfgStrength,
      builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => i0.ColumnFilters(column));

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => i0.ColumnFilters(column));
}

class $$QueueTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$QueueTable> {
  $$QueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get lyrics => $composableBuilder(
      column: $table.lyrics, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get negativeTags => $composableBuilder(
      column: $table.negativeTags,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get inputFile => $composableBuilder(
      column: $table.inputFile,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get clientRequestedId => $composableBuilder(
      column: $table.clientRequestedId,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get lrcPrompt => $composableBuilder(
      column: $table.lrcPrompt,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<String> get processingStatus => $composableBuilder(
      column: $table.processingStatus,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<int> get cfgStrength => $composableBuilder(
      column: $table.cfgStrength,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted,
      builder: (column) => i0.ColumnOrderings(column));

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt,
      builder: (column) => i0.ColumnOrderings(column));
}

class $$QueueTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$QueueTable> {
  $$QueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  i0.GeneratedColumn<String> get lyrics =>
      $composableBuilder(column: $table.lyrics, builder: (column) => column);

  i0.GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  i0.GeneratedColumn<String> get negativeTags => $composableBuilder(
      column: $table.negativeTags, builder: (column) => column);

  i0.GeneratedColumn<String> get inputFile =>
      $composableBuilder(column: $table.inputFile, builder: (column) => column);

  i0.GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  i0.GeneratedColumn<String> get clientRequestedId => $composableBuilder(
      column: $table.clientRequestedId, builder: (column) => column);

  i0.GeneratedColumn<String> get lrcPrompt =>
      $composableBuilder(column: $table.lrcPrompt, builder: (column) => column);

  i0.GeneratedColumn<String> get processingStatus => $composableBuilder(
      column: $table.processingStatus, builder: (column) => column);

  i0.GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  i0.GeneratedColumn<int> get cfgStrength => $composableBuilder(
      column: $table.cfgStrength, builder: (column) => column);

  i0.GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  i0.GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  i0.GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$QueueTableTableManager extends i0.RootTableManager<
    i0.GeneratedDatabase,
    i1.$QueueTable,
    i1.Queue,
    i1.$$QueueTableFilterComposer,
    i1.$$QueueTableOrderingComposer,
    i1.$$QueueTableAnnotationComposer,
    $$QueueTableCreateCompanionBuilder,
    $$QueueTableUpdateCompanionBuilder,
    (
      i1.Queue,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$QueueTable, i1.Queue>
    ),
    i1.Queue,
    i0.PrefetchHooks Function()> {
  $$QueueTableTableManager(i0.GeneratedDatabase db, i1.$QueueTable table)
      : super(i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$QueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$QueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$$QueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            i0.Value<String> id = const i0.Value.absent(),
            i0.Value<String> title = const i0.Value.absent(),
            i0.Value<String?> lyrics = const i0.Value.absent(),
            i0.Value<String> tags = const i0.Value.absent(),
            i0.Value<String?> negativeTags = const i0.Value.absent(),
            i0.Value<String?> inputFile = const i0.Value.absent(),
            i0.Value<String> model = const i0.Value.absent(),
            i0.Value<String> clientRequestedId = const i0.Value.absent(),
            i0.Value<String> lrcPrompt = const i0.Value.absent(),
            i0.Value<String> processingStatus = const i0.Value.absent(),
            i0.Value<int> steps = const i0.Value.absent(),
            i0.Value<int> cfgStrength = const i0.Value.absent(),
            i0.Value<int> duration = const i0.Value.absent(),
            i0.Value<bool> isFavorite = const i0.Value.absent(),
            i0.Value<bool> isDeleted = const i0.Value.absent(),
            i0.Value<DateTime> createdAt = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.QueueCompanion(
            id: id,
            title: title,
            lyrics: lyrics,
            tags: tags,
            negativeTags: negativeTags,
            inputFile: inputFile,
            model: model,
            clientRequestedId: clientRequestedId,
            lrcPrompt: lrcPrompt,
            processingStatus: processingStatus,
            steps: steps,
            cfgStrength: cfgStrength,
            duration: duration,
            isFavorite: isFavorite,
            isDeleted: isDeleted,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            i0.Value<String?> lyrics = const i0.Value.absent(),
            required String tags,
            i0.Value<String?> negativeTags = const i0.Value.absent(),
            i0.Value<String?> inputFile = const i0.Value.absent(),
            required String model,
            required String clientRequestedId,
            required String lrcPrompt,
            required String processingStatus,
            required int steps,
            required int cfgStrength,
            required int duration,
            i0.Value<bool> isFavorite = const i0.Value.absent(),
            i0.Value<bool> isDeleted = const i0.Value.absent(),
            i0.Value<DateTime> createdAt = const i0.Value.absent(),
            i0.Value<int> rowid = const i0.Value.absent(),
          }) =>
              i1.QueueCompanion.insert(
            id: id,
            title: title,
            lyrics: lyrics,
            tags: tags,
            negativeTags: negativeTags,
            inputFile: inputFile,
            model: model,
            clientRequestedId: clientRequestedId,
            lrcPrompt: lrcPrompt,
            processingStatus: processingStatus,
            steps: steps,
            cfgStrength: cfgStrength,
            duration: duration,
            isFavorite: isFavorite,
            isDeleted: isDeleted,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QueueTableProcessedTableManager = i0.ProcessedTableManager<
    i0.GeneratedDatabase,
    i1.$QueueTable,
    i1.Queue,
    i1.$$QueueTableFilterComposer,
    i1.$$QueueTableOrderingComposer,
    i1.$$QueueTableAnnotationComposer,
    $$QueueTableCreateCompanionBuilder,
    $$QueueTableUpdateCompanionBuilder,
    (
      i1.Queue,
      i0.BaseReferences<i0.GeneratedDatabase, i1.$QueueTable, i1.Queue>
    ),
    i1.Queue,
    i0.PrefetchHooks Function()>;

class $MusicTable extends i2.Music with i0.TableInfo<$MusicTable, i1.Music> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MusicTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<String> id = i0.GeneratedColumn<String>(
      'id', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _titleMeta =
      const i0.VerificationMeta('title');
  @override
  late final i0.GeneratedColumn<String> title = i0.GeneratedColumn<String>(
      'title', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _lyricsMeta =
      const i0.VerificationMeta('lyrics');
  @override
  late final i0.GeneratedColumn<String> lyrics = i0.GeneratedColumn<String>(
      'lyrics', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _tagsMeta =
      const i0.VerificationMeta('tags');
  @override
  late final i0.GeneratedColumn<String> tags = i0.GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _negativeTagsMeta =
      const i0.VerificationMeta('negativeTags');
  @override
  late final i0.GeneratedColumn<String> negativeTags =
      i0.GeneratedColumn<String>('negative_tags', aliasedName, false,
          type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _inputFileMeta =
      const i0.VerificationMeta('inputFile');
  @override
  late final i0.GeneratedColumn<String> inputFile = i0.GeneratedColumn<String>(
      'input_file', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _modelMeta =
      const i0.VerificationMeta('model');
  @override
  late final i0.GeneratedColumn<String> model = i0.GeneratedColumn<String>(
      'model', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _clientProcessingIdMeta =
      const i0.VerificationMeta('clientProcessingId');
  @override
  late final i0.GeneratedColumn<String> clientProcessingId =
      i0.GeneratedColumn<String>('client_processing_id', aliasedName, false,
          type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _lrcPromptMeta =
      const i0.VerificationMeta('lrcPrompt');
  @override
  late final i0.GeneratedColumn<String> lrcPrompt = i0.GeneratedColumn<String>(
      'lrc_prompt', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _processingStatusMeta =
      const i0.VerificationMeta('processingStatus');
  @override
  late final i0.GeneratedColumn<String> processingStatus =
      i0.GeneratedColumn<String>('processing_status', aliasedName, false,
          type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _stepsMeta =
      const i0.VerificationMeta('steps');
  @override
  late final i0.GeneratedColumn<int> steps = i0.GeneratedColumn<int>(
      'steps', aliasedName, false,
      type: i0.DriftSqlType.int, requiredDuringInsert: true);
  static const i0.VerificationMeta _cfgStrengthMeta =
      const i0.VerificationMeta('cfgStrength');
  @override
  late final i0.GeneratedColumn<int> cfgStrength = i0.GeneratedColumn<int>(
      'cfg_strength', aliasedName, false,
      type: i0.DriftSqlType.int, requiredDuringInsert: true);
  static const i0.VerificationMeta _durationMeta =
      const i0.VerificationMeta('duration');
  @override
  late final i0.GeneratedColumn<int> duration = i0.GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: i0.DriftSqlType.int, requiredDuringInsert: true);
  static const i0.VerificationMeta _isFavoriteMeta =
      const i0.VerificationMeta('isFavorite');
  @override
  late final i0.GeneratedColumn<bool> isFavorite = i0.GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: i0.DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
          'CHECK ("is_favorite" IN (0, 1))'));
  static const i0.VerificationMeta _isDeletedMeta =
      const i0.VerificationMeta('isDeleted');
  @override
  late final i0.GeneratedColumn<bool> isDeleted = i0.GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: i0.DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
          'CHECK ("is_deleted" IN (0, 1))'));
  static const i0.VerificationMeta _createdAtMeta =
      const i0.VerificationMeta('createdAt');
  @override
  late final i0.GeneratedColumn<DateTime> createdAt =
      i0.GeneratedColumn<DateTime>('created_at', aliasedName, false,
          type: i0.DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: i3.currentDateAndTime);
  @override
  List<i0.GeneratedColumn> get $columns => [
        id,
        title,
        lyrics,
        tags,
        negativeTags,
        inputFile,
        model,
        clientProcessingId,
        lrcPrompt,
        processingStatus,
        steps,
        cfgStrength,
        duration,
        isFavorite,
        isDeleted,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'music';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.Music> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('lyrics')) {
      context.handle(_lyricsMeta,
          lyrics.isAcceptableOrUnknown(data['lyrics']!, _lyricsMeta));
    } else if (isInserting) {
      context.missing(_lyricsMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    if (data.containsKey('negative_tags')) {
      context.handle(
          _negativeTagsMeta,
          negativeTags.isAcceptableOrUnknown(
              data['negative_tags']!, _negativeTagsMeta));
    } else if (isInserting) {
      context.missing(_negativeTagsMeta);
    }
    if (data.containsKey('input_file')) {
      context.handle(_inputFileMeta,
          inputFile.isAcceptableOrUnknown(data['input_file']!, _inputFileMeta));
    } else if (isInserting) {
      context.missing(_inputFileMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
          _modelMeta, model.isAcceptableOrUnknown(data['model']!, _modelMeta));
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('client_processing_id')) {
      context.handle(
          _clientProcessingIdMeta,
          clientProcessingId.isAcceptableOrUnknown(
              data['client_processing_id']!, _clientProcessingIdMeta));
    } else if (isInserting) {
      context.missing(_clientProcessingIdMeta);
    }
    if (data.containsKey('lrc_prompt')) {
      context.handle(_lrcPromptMeta,
          lrcPrompt.isAcceptableOrUnknown(data['lrc_prompt']!, _lrcPromptMeta));
    } else if (isInserting) {
      context.missing(_lrcPromptMeta);
    }
    if (data.containsKey('processing_status')) {
      context.handle(
          _processingStatusMeta,
          processingStatus.isAcceptableOrUnknown(
              data['processing_status']!, _processingStatusMeta));
    } else if (isInserting) {
      context.missing(_processingStatusMeta);
    }
    if (data.containsKey('steps')) {
      context.handle(
          _stepsMeta, steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta));
    } else if (isInserting) {
      context.missing(_stepsMeta);
    }
    if (data.containsKey('cfg_strength')) {
      context.handle(
          _cfgStrengthMeta,
          cfgStrength.isAcceptableOrUnknown(
              data['cfg_strength']!, _cfgStrengthMeta));
    } else if (isInserting) {
      context.missing(_cfgStrengthMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    } else if (isInserting) {
      context.missing(_isDeletedMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Music map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Music(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}title'])!,
      lyrics: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}lyrics'])!,
      tags: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}tags'])!,
      negativeTags: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}negative_tags'])!,
      inputFile: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}input_file'])!,
      model: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}model'])!,
      clientProcessingId: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string,
          data['${effectivePrefix}client_processing_id'])!,
      lrcPrompt: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}lrc_prompt'])!,
      processingStatus: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}processing_status'])!,
      steps: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}steps'])!,
      cfgStrength: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}cfg_strength'])!,
      duration: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}duration'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MusicTable createAlias(String alias) {
    return $MusicTable(attachedDatabase, alias);
  }
}

class Music extends i0.DataClass implements i0.Insertable<i1.Music> {
  final String id;
  final String title;
  final String lyrics;
  final String tags;
  final String negativeTags;
  final String inputFile;
  final String model;
  final String clientProcessingId;
  final String lrcPrompt;
  final String processingStatus;
  final int steps;
  final int cfgStrength;
  final int duration;
  final bool isFavorite;
  final bool isDeleted;
  final DateTime createdAt;
  const Music(
      {required this.id,
      required this.title,
      required this.lyrics,
      required this.tags,
      required this.negativeTags,
      required this.inputFile,
      required this.model,
      required this.clientProcessingId,
      required this.lrcPrompt,
      required this.processingStatus,
      required this.steps,
      required this.cfgStrength,
      required this.duration,
      required this.isFavorite,
      required this.isDeleted,
      required this.createdAt});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    map['title'] = i0.Variable<String>(title);
    map['lyrics'] = i0.Variable<String>(lyrics);
    map['tags'] = i0.Variable<String>(tags);
    map['negative_tags'] = i0.Variable<String>(negativeTags);
    map['input_file'] = i0.Variable<String>(inputFile);
    map['model'] = i0.Variable<String>(model);
    map['client_processing_id'] = i0.Variable<String>(clientProcessingId);
    map['lrc_prompt'] = i0.Variable<String>(lrcPrompt);
    map['processing_status'] = i0.Variable<String>(processingStatus);
    map['steps'] = i0.Variable<int>(steps);
    map['cfg_strength'] = i0.Variable<int>(cfgStrength);
    map['duration'] = i0.Variable<int>(duration);
    map['is_favorite'] = i0.Variable<bool>(isFavorite);
    map['is_deleted'] = i0.Variable<bool>(isDeleted);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    return map;
  }

  i1.MusicCompanion toCompanion(bool nullToAbsent) {
    return i1.MusicCompanion(
      id: i0.Value(id),
      title: i0.Value(title),
      lyrics: i0.Value(lyrics),
      tags: i0.Value(tags),
      negativeTags: i0.Value(negativeTags),
      inputFile: i0.Value(inputFile),
      model: i0.Value(model),
      clientProcessingId: i0.Value(clientProcessingId),
      lrcPrompt: i0.Value(lrcPrompt),
      processingStatus: i0.Value(processingStatus),
      steps: i0.Value(steps),
      cfgStrength: i0.Value(cfgStrength),
      duration: i0.Value(duration),
      isFavorite: i0.Value(isFavorite),
      isDeleted: i0.Value(isDeleted),
      createdAt: i0.Value(createdAt),
    );
  }

  factory Music.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Music(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      lyrics: serializer.fromJson<String>(json['lyrics']),
      tags: serializer.fromJson<String>(json['tags']),
      negativeTags: serializer.fromJson<String>(json['negativeTags']),
      inputFile: serializer.fromJson<String>(json['inputFile']),
      model: serializer.fromJson<String>(json['model']),
      clientProcessingId:
          serializer.fromJson<String>(json['clientProcessingId']),
      lrcPrompt: serializer.fromJson<String>(json['lrcPrompt']),
      processingStatus: serializer.fromJson<String>(json['processingStatus']),
      steps: serializer.fromJson<int>(json['steps']),
      cfgStrength: serializer.fromJson<int>(json['cfgStrength']),
      duration: serializer.fromJson<int>(json['duration']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'lyrics': serializer.toJson<String>(lyrics),
      'tags': serializer.toJson<String>(tags),
      'negativeTags': serializer.toJson<String>(negativeTags),
      'inputFile': serializer.toJson<String>(inputFile),
      'model': serializer.toJson<String>(model),
      'clientProcessingId': serializer.toJson<String>(clientProcessingId),
      'lrcPrompt': serializer.toJson<String>(lrcPrompt),
      'processingStatus': serializer.toJson<String>(processingStatus),
      'steps': serializer.toJson<int>(steps),
      'cfgStrength': serializer.toJson<int>(cfgStrength),
      'duration': serializer.toJson<int>(duration),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  i1.Music copyWith(
          {String? id,
          String? title,
          String? lyrics,
          String? tags,
          String? negativeTags,
          String? inputFile,
          String? model,
          String? clientProcessingId,
          String? lrcPrompt,
          String? processingStatus,
          int? steps,
          int? cfgStrength,
          int? duration,
          bool? isFavorite,
          bool? isDeleted,
          DateTime? createdAt}) =>
      i1.Music(
        id: id ?? this.id,
        title: title ?? this.title,
        lyrics: lyrics ?? this.lyrics,
        tags: tags ?? this.tags,
        negativeTags: negativeTags ?? this.negativeTags,
        inputFile: inputFile ?? this.inputFile,
        model: model ?? this.model,
        clientProcessingId: clientProcessingId ?? this.clientProcessingId,
        lrcPrompt: lrcPrompt ?? this.lrcPrompt,
        processingStatus: processingStatus ?? this.processingStatus,
        steps: steps ?? this.steps,
        cfgStrength: cfgStrength ?? this.cfgStrength,
        duration: duration ?? this.duration,
        isFavorite: isFavorite ?? this.isFavorite,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
      );
  Music copyWithCompanion(i1.MusicCompanion data) {
    return Music(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      lyrics: data.lyrics.present ? data.lyrics.value : this.lyrics,
      tags: data.tags.present ? data.tags.value : this.tags,
      negativeTags: data.negativeTags.present
          ? data.negativeTags.value
          : this.negativeTags,
      inputFile: data.inputFile.present ? data.inputFile.value : this.inputFile,
      model: data.model.present ? data.model.value : this.model,
      clientProcessingId: data.clientProcessingId.present
          ? data.clientProcessingId.value
          : this.clientProcessingId,
      lrcPrompt: data.lrcPrompt.present ? data.lrcPrompt.value : this.lrcPrompt,
      processingStatus: data.processingStatus.present
          ? data.processingStatus.value
          : this.processingStatus,
      steps: data.steps.present ? data.steps.value : this.steps,
      cfgStrength:
          data.cfgStrength.present ? data.cfgStrength.value : this.cfgStrength,
      duration: data.duration.present ? data.duration.value : this.duration,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Music(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('lyrics: $lyrics, ')
          ..write('tags: $tags, ')
          ..write('negativeTags: $negativeTags, ')
          ..write('inputFile: $inputFile, ')
          ..write('model: $model, ')
          ..write('clientProcessingId: $clientProcessingId, ')
          ..write('lrcPrompt: $lrcPrompt, ')
          ..write('processingStatus: $processingStatus, ')
          ..write('steps: $steps, ')
          ..write('cfgStrength: $cfgStrength, ')
          ..write('duration: $duration, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      lyrics,
      tags,
      negativeTags,
      inputFile,
      model,
      clientProcessingId,
      lrcPrompt,
      processingStatus,
      steps,
      cfgStrength,
      duration,
      isFavorite,
      isDeleted,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Music &&
          other.id == this.id &&
          other.title == this.title &&
          other.lyrics == this.lyrics &&
          other.tags == this.tags &&
          other.negativeTags == this.negativeTags &&
          other.inputFile == this.inputFile &&
          other.model == this.model &&
          other.clientProcessingId == this.clientProcessingId &&
          other.lrcPrompt == this.lrcPrompt &&
          other.processingStatus == this.processingStatus &&
          other.steps == this.steps &&
          other.cfgStrength == this.cfgStrength &&
          other.duration == this.duration &&
          other.isFavorite == this.isFavorite &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt);
}

class MusicCompanion extends i0.UpdateCompanion<i1.Music> {
  final i0.Value<String> id;
  final i0.Value<String> title;
  final i0.Value<String> lyrics;
  final i0.Value<String> tags;
  final i0.Value<String> negativeTags;
  final i0.Value<String> inputFile;
  final i0.Value<String> model;
  final i0.Value<String> clientProcessingId;
  final i0.Value<String> lrcPrompt;
  final i0.Value<String> processingStatus;
  final i0.Value<int> steps;
  final i0.Value<int> cfgStrength;
  final i0.Value<int> duration;
  final i0.Value<bool> isFavorite;
  final i0.Value<bool> isDeleted;
  final i0.Value<DateTime> createdAt;
  final i0.Value<int> rowid;
  const MusicCompanion({
    this.id = const i0.Value.absent(),
    this.title = const i0.Value.absent(),
    this.lyrics = const i0.Value.absent(),
    this.tags = const i0.Value.absent(),
    this.negativeTags = const i0.Value.absent(),
    this.inputFile = const i0.Value.absent(),
    this.model = const i0.Value.absent(),
    this.clientProcessingId = const i0.Value.absent(),
    this.lrcPrompt = const i0.Value.absent(),
    this.processingStatus = const i0.Value.absent(),
    this.steps = const i0.Value.absent(),
    this.cfgStrength = const i0.Value.absent(),
    this.duration = const i0.Value.absent(),
    this.isFavorite = const i0.Value.absent(),
    this.isDeleted = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  MusicCompanion.insert({
    required String id,
    required String title,
    required String lyrics,
    required String tags,
    required String negativeTags,
    required String inputFile,
    required String model,
    required String clientProcessingId,
    required String lrcPrompt,
    required String processingStatus,
    required int steps,
    required int cfgStrength,
    required int duration,
    required bool isFavorite,
    required bool isDeleted,
    this.createdAt = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  })  : id = i0.Value(id),
        title = i0.Value(title),
        lyrics = i0.Value(lyrics),
        tags = i0.Value(tags),
        negativeTags = i0.Value(negativeTags),
        inputFile = i0.Value(inputFile),
        model = i0.Value(model),
        clientProcessingId = i0.Value(clientProcessingId),
        lrcPrompt = i0.Value(lrcPrompt),
        processingStatus = i0.Value(processingStatus),
        steps = i0.Value(steps),
        cfgStrength = i0.Value(cfgStrength),
        duration = i0.Value(duration),
        isFavorite = i0.Value(isFavorite),
        isDeleted = i0.Value(isDeleted);
  static i0.Insertable<i1.Music> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? title,
    i0.Expression<String>? lyrics,
    i0.Expression<String>? tags,
    i0.Expression<String>? negativeTags,
    i0.Expression<String>? inputFile,
    i0.Expression<String>? model,
    i0.Expression<String>? clientProcessingId,
    i0.Expression<String>? lrcPrompt,
    i0.Expression<String>? processingStatus,
    i0.Expression<int>? steps,
    i0.Expression<int>? cfgStrength,
    i0.Expression<int>? duration,
    i0.Expression<bool>? isFavorite,
    i0.Expression<bool>? isDeleted,
    i0.Expression<DateTime>? createdAt,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (lyrics != null) 'lyrics': lyrics,
      if (tags != null) 'tags': tags,
      if (negativeTags != null) 'negative_tags': negativeTags,
      if (inputFile != null) 'input_file': inputFile,
      if (model != null) 'model': model,
      if (clientProcessingId != null)
        'client_processing_id': clientProcessingId,
      if (lrcPrompt != null) 'lrc_prompt': lrcPrompt,
      if (processingStatus != null) 'processing_status': processingStatus,
      if (steps != null) 'steps': steps,
      if (cfgStrength != null) 'cfg_strength': cfgStrength,
      if (duration != null) 'duration': duration,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.MusicCompanion copyWith(
      {i0.Value<String>? id,
      i0.Value<String>? title,
      i0.Value<String>? lyrics,
      i0.Value<String>? tags,
      i0.Value<String>? negativeTags,
      i0.Value<String>? inputFile,
      i0.Value<String>? model,
      i0.Value<String>? clientProcessingId,
      i0.Value<String>? lrcPrompt,
      i0.Value<String>? processingStatus,
      i0.Value<int>? steps,
      i0.Value<int>? cfgStrength,
      i0.Value<int>? duration,
      i0.Value<bool>? isFavorite,
      i0.Value<bool>? isDeleted,
      i0.Value<DateTime>? createdAt,
      i0.Value<int>? rowid}) {
    return i1.MusicCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      lyrics: lyrics ?? this.lyrics,
      tags: tags ?? this.tags,
      negativeTags: negativeTags ?? this.negativeTags,
      inputFile: inputFile ?? this.inputFile,
      model: model ?? this.model,
      clientProcessingId: clientProcessingId ?? this.clientProcessingId,
      lrcPrompt: lrcPrompt ?? this.lrcPrompt,
      processingStatus: processingStatus ?? this.processingStatus,
      steps: steps ?? this.steps,
      cfgStrength: cfgStrength ?? this.cfgStrength,
      duration: duration ?? this.duration,
      isFavorite: isFavorite ?? this.isFavorite,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = i0.Variable<String>(title.value);
    }
    if (lyrics.present) {
      map['lyrics'] = i0.Variable<String>(lyrics.value);
    }
    if (tags.present) {
      map['tags'] = i0.Variable<String>(tags.value);
    }
    if (negativeTags.present) {
      map['negative_tags'] = i0.Variable<String>(negativeTags.value);
    }
    if (inputFile.present) {
      map['input_file'] = i0.Variable<String>(inputFile.value);
    }
    if (model.present) {
      map['model'] = i0.Variable<String>(model.value);
    }
    if (clientProcessingId.present) {
      map['client_processing_id'] =
          i0.Variable<String>(clientProcessingId.value);
    }
    if (lrcPrompt.present) {
      map['lrc_prompt'] = i0.Variable<String>(lrcPrompt.value);
    }
    if (processingStatus.present) {
      map['processing_status'] = i0.Variable<String>(processingStatus.value);
    }
    if (steps.present) {
      map['steps'] = i0.Variable<int>(steps.value);
    }
    if (cfgStrength.present) {
      map['cfg_strength'] = i0.Variable<int>(cfgStrength.value);
    }
    if (duration.present) {
      map['duration'] = i0.Variable<int>(duration.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = i0.Variable<bool>(isFavorite.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = i0.Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MusicCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('lyrics: $lyrics, ')
          ..write('tags: $tags, ')
          ..write('negativeTags: $negativeTags, ')
          ..write('inputFile: $inputFile, ')
          ..write('model: $model, ')
          ..write('clientProcessingId: $clientProcessingId, ')
          ..write('lrcPrompt: $lrcPrompt, ')
          ..write('processingStatus: $processingStatus, ')
          ..write('steps: $steps, ')
          ..write('cfgStrength: $cfgStrength, ')
          ..write('duration: $duration, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PromptTable extends i2.Prompt
    with i0.TableInfo<$PromptTable, i1.Prompt> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PromptTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<String> id = i0.GeneratedColumn<String>(
      'id', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _promptMeta =
      const i0.VerificationMeta('prompt');
  @override
  late final i0.GeneratedColumn<String> prompt = i0.GeneratedColumn<String>(
      'prompt', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _categoryMeta =
      const i0.VerificationMeta('category');
  @override
  late final i0.GeneratedColumn<String> category = i0.GeneratedColumn<String>(
      'category', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _createdAtMeta =
      const i0.VerificationMeta('createdAt');
  @override
  late final i0.GeneratedColumn<DateTime> createdAt =
      i0.GeneratedColumn<DateTime>('created_at', aliasedName, false,
          type: i0.DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: i3.currentDateAndTime);
  @override
  List<i0.GeneratedColumn> get $columns => [id, prompt, category, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prompt';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.Prompt> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('prompt')) {
      context.handle(_promptMeta,
          prompt.isAcceptableOrUnknown(data['prompt']!, _promptMeta));
    } else if (isInserting) {
      context.missing(_promptMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Prompt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Prompt(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}id'])!,
      prompt: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}prompt'])!,
      category: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}category'])!,
      createdAt: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PromptTable createAlias(String alias) {
    return $PromptTable(attachedDatabase, alias);
  }
}

class Prompt extends i0.DataClass implements i0.Insertable<i1.Prompt> {
  final String id;
  final String prompt;
  final String category;
  final DateTime createdAt;
  const Prompt(
      {required this.id,
      required this.prompt,
      required this.category,
      required this.createdAt});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    map['prompt'] = i0.Variable<String>(prompt);
    map['category'] = i0.Variable<String>(category);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    return map;
  }

  i1.PromptCompanion toCompanion(bool nullToAbsent) {
    return i1.PromptCompanion(
      id: i0.Value(id),
      prompt: i0.Value(prompt),
      category: i0.Value(category),
      createdAt: i0.Value(createdAt),
    );
  }

  factory Prompt.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Prompt(
      id: serializer.fromJson<String>(json['id']),
      prompt: serializer.fromJson<String>(json['prompt']),
      category: serializer.fromJson<String>(json['category']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'prompt': serializer.toJson<String>(prompt),
      'category': serializer.toJson<String>(category),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  i1.Prompt copyWith(
          {String? id,
          String? prompt,
          String? category,
          DateTime? createdAt}) =>
      i1.Prompt(
        id: id ?? this.id,
        prompt: prompt ?? this.prompt,
        category: category ?? this.category,
        createdAt: createdAt ?? this.createdAt,
      );
  Prompt copyWithCompanion(i1.PromptCompanion data) {
    return Prompt(
      id: data.id.present ? data.id.value : this.id,
      prompt: data.prompt.present ? data.prompt.value : this.prompt,
      category: data.category.present ? data.category.value : this.category,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Prompt(')
          ..write('id: $id, ')
          ..write('prompt: $prompt, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, prompt, category, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Prompt &&
          other.id == this.id &&
          other.prompt == this.prompt &&
          other.category == this.category &&
          other.createdAt == this.createdAt);
}

class PromptCompanion extends i0.UpdateCompanion<i1.Prompt> {
  final i0.Value<String> id;
  final i0.Value<String> prompt;
  final i0.Value<String> category;
  final i0.Value<DateTime> createdAt;
  final i0.Value<int> rowid;
  const PromptCompanion({
    this.id = const i0.Value.absent(),
    this.prompt = const i0.Value.absent(),
    this.category = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  PromptCompanion.insert({
    required String id,
    required String prompt,
    required String category,
    this.createdAt = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  })  : id = i0.Value(id),
        prompt = i0.Value(prompt),
        category = i0.Value(category);
  static i0.Insertable<i1.Prompt> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? prompt,
    i0.Expression<String>? category,
    i0.Expression<DateTime>? createdAt,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (prompt != null) 'prompt': prompt,
      if (category != null) 'category': category,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.PromptCompanion copyWith(
      {i0.Value<String>? id,
      i0.Value<String>? prompt,
      i0.Value<String>? category,
      i0.Value<DateTime>? createdAt,
      i0.Value<int>? rowid}) {
    return i1.PromptCompanion(
      id: id ?? this.id,
      prompt: prompt ?? this.prompt,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<String>(id.value);
    }
    if (prompt.present) {
      map['prompt'] = i0.Variable<String>(prompt.value);
    }
    if (category.present) {
      map['category'] = i0.Variable<String>(category.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PromptCompanion(')
          ..write('id: $id, ')
          ..write('prompt: $prompt, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvitationsTable extends i2.Invitations
    with i0.TableInfo<$InvitationsTable, i1.Invitations> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvitationsTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<String> id = i0.GeneratedColumn<String>(
      'id', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _clientAcceptedIdMeta =
      const i0.VerificationMeta('clientAcceptedId');
  @override
  late final i0.GeneratedColumn<String> clientAcceptedId =
      i0.GeneratedColumn<String>('client_accepted_id', aliasedName, true,
          type: i0.DriftSqlType.string, requiredDuringInsert: false);
  static const i0.VerificationMeta _codeMeta =
      const i0.VerificationMeta('code');
  @override
  late final i0.GeneratedColumn<String> code = i0.GeneratedColumn<String>(
      'code', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _createdAtMeta =
      const i0.VerificationMeta('createdAt');
  @override
  late final i0.GeneratedColumn<DateTime> createdAt =
      i0.GeneratedColumn<DateTime>('created_at', aliasedName, false,
          type: i0.DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: i3.currentDateAndTime);
  @override
  List<i0.GeneratedColumn> get $columns =>
      [id, clientAcceptedId, code, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invitations';
  @override
  i0.VerificationContext validateIntegrity(
      i0.Insertable<i1.Invitations> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_accepted_id')) {
      context.handle(
          _clientAcceptedIdMeta,
          clientAcceptedId.isAcceptableOrUnknown(
              data['client_accepted_id']!, _clientAcceptedIdMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Invitations map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Invitations(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}id'])!,
      clientAcceptedId: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}client_accepted_id']),
      code: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}code'])!,
      createdAt: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $InvitationsTable createAlias(String alias) {
    return $InvitationsTable(attachedDatabase, alias);
  }
}

class Invitations extends i0.DataClass
    implements i0.Insertable<i1.Invitations> {
  final String id;
  final String? clientAcceptedId;
  final String code;
  final DateTime createdAt;
  const Invitations(
      {required this.id,
      this.clientAcceptedId,
      required this.code,
      required this.createdAt});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    if (!nullToAbsent || clientAcceptedId != null) {
      map['client_accepted_id'] = i0.Variable<String>(clientAcceptedId);
    }
    map['code'] = i0.Variable<String>(code);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    return map;
  }

  i1.InvitationsCompanion toCompanion(bool nullToAbsent) {
    return i1.InvitationsCompanion(
      id: i0.Value(id),
      clientAcceptedId: clientAcceptedId == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(clientAcceptedId),
      code: i0.Value(code),
      createdAt: i0.Value(createdAt),
    );
  }

  factory Invitations.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Invitations(
      id: serializer.fromJson<String>(json['id']),
      clientAcceptedId: serializer.fromJson<String?>(json['clientAcceptedId']),
      code: serializer.fromJson<String>(json['code']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientAcceptedId': serializer.toJson<String?>(clientAcceptedId),
      'code': serializer.toJson<String>(code),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  i1.Invitations copyWith(
          {String? id,
          i0.Value<String?> clientAcceptedId = const i0.Value.absent(),
          String? code,
          DateTime? createdAt}) =>
      i1.Invitations(
        id: id ?? this.id,
        clientAcceptedId: clientAcceptedId.present
            ? clientAcceptedId.value
            : this.clientAcceptedId,
        code: code ?? this.code,
        createdAt: createdAt ?? this.createdAt,
      );
  Invitations copyWithCompanion(i1.InvitationsCompanion data) {
    return Invitations(
      id: data.id.present ? data.id.value : this.id,
      clientAcceptedId: data.clientAcceptedId.present
          ? data.clientAcceptedId.value
          : this.clientAcceptedId,
      code: data.code.present ? data.code.value : this.code,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invitations(')
          ..write('id: $id, ')
          ..write('clientAcceptedId: $clientAcceptedId, ')
          ..write('code: $code, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, clientAcceptedId, code, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Invitations &&
          other.id == this.id &&
          other.clientAcceptedId == this.clientAcceptedId &&
          other.code == this.code &&
          other.createdAt == this.createdAt);
}

class InvitationsCompanion extends i0.UpdateCompanion<i1.Invitations> {
  final i0.Value<String> id;
  final i0.Value<String?> clientAcceptedId;
  final i0.Value<String> code;
  final i0.Value<DateTime> createdAt;
  final i0.Value<int> rowid;
  const InvitationsCompanion({
    this.id = const i0.Value.absent(),
    this.clientAcceptedId = const i0.Value.absent(),
    this.code = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  InvitationsCompanion.insert({
    required String id,
    this.clientAcceptedId = const i0.Value.absent(),
    required String code,
    this.createdAt = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  })  : id = i0.Value(id),
        code = i0.Value(code);
  static i0.Insertable<i1.Invitations> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? clientAcceptedId,
    i0.Expression<String>? code,
    i0.Expression<DateTime>? createdAt,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientAcceptedId != null) 'client_accepted_id': clientAcceptedId,
      if (code != null) 'code': code,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.InvitationsCompanion copyWith(
      {i0.Value<String>? id,
      i0.Value<String?>? clientAcceptedId,
      i0.Value<String>? code,
      i0.Value<DateTime>? createdAt,
      i0.Value<int>? rowid}) {
    return i1.InvitationsCompanion(
      id: id ?? this.id,
      clientAcceptedId: clientAcceptedId ?? this.clientAcceptedId,
      code: code ?? this.code,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<String>(id.value);
    }
    if (clientAcceptedId.present) {
      map['client_accepted_id'] = i0.Variable<String>(clientAcceptedId.value);
    }
    if (code.present) {
      map['code'] = i0.Variable<String>(code.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvitationsCompanion(')
          ..write('id: $id, ')
          ..write('clientAcceptedId: $clientAcceptedId, ')
          ..write('code: $code, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConnectionsTable extends i2.Connections
    with i0.TableInfo<$ConnectionsTable, i1.Connections> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConnectionsTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<String> id = i0.GeneratedColumn<String>(
      'id', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _nicknameMeta =
      const i0.VerificationMeta('nickname');
  @override
  late final i0.GeneratedColumn<String> nickname = i0.GeneratedColumn<String>(
      'nickname', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _directionMeta =
      const i0.VerificationMeta('direction');
  @override
  late final i0.GeneratedColumn<String> direction = i0.GeneratedColumn<String>(
      'direction', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _clientIdMeta =
      const i0.VerificationMeta('clientId');
  @override
  late final i0.GeneratedColumn<String> clientId = i0.GeneratedColumn<String>(
      'client_id', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _createdAtMeta =
      const i0.VerificationMeta('createdAt');
  @override
  late final i0.GeneratedColumn<DateTime> createdAt =
      i0.GeneratedColumn<DateTime>('created_at', aliasedName, false,
          type: i0.DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: i3.currentDateAndTime);
  @override
  List<i0.GeneratedColumn> get $columns =>
      [id, nickname, direction, clientId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'connections';
  @override
  i0.VerificationContext validateIntegrity(
      i0.Insertable<i1.Connections> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(_nicknameMeta,
          nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta));
    } else if (isInserting) {
      context.missing(_nicknameMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(_directionMeta,
          direction.isAcceptableOrUnknown(data['direction']!, _directionMeta));
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Connections map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Connections(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}id'])!,
      nickname: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}nickname'])!,
      direction: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}direction'])!,
      clientId: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}client_id'])!,
      createdAt: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ConnectionsTable createAlias(String alias) {
    return $ConnectionsTable(attachedDatabase, alias);
  }
}

class Connections extends i0.DataClass
    implements i0.Insertable<i1.Connections> {
  final String id;
  final String nickname;
  final String direction;
  final String clientId;
  final DateTime createdAt;
  const Connections(
      {required this.id,
      required this.nickname,
      required this.direction,
      required this.clientId,
      required this.createdAt});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    map['nickname'] = i0.Variable<String>(nickname);
    map['direction'] = i0.Variable<String>(direction);
    map['client_id'] = i0.Variable<String>(clientId);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    return map;
  }

  i1.ConnectionsCompanion toCompanion(bool nullToAbsent) {
    return i1.ConnectionsCompanion(
      id: i0.Value(id),
      nickname: i0.Value(nickname),
      direction: i0.Value(direction),
      clientId: i0.Value(clientId),
      createdAt: i0.Value(createdAt),
    );
  }

  factory Connections.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Connections(
      id: serializer.fromJson<String>(json['id']),
      nickname: serializer.fromJson<String>(json['nickname']),
      direction: serializer.fromJson<String>(json['direction']),
      clientId: serializer.fromJson<String>(json['clientId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nickname': serializer.toJson<String>(nickname),
      'direction': serializer.toJson<String>(direction),
      'clientId': serializer.toJson<String>(clientId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  i1.Connections copyWith(
          {String? id,
          String? nickname,
          String? direction,
          String? clientId,
          DateTime? createdAt}) =>
      i1.Connections(
        id: id ?? this.id,
        nickname: nickname ?? this.nickname,
        direction: direction ?? this.direction,
        clientId: clientId ?? this.clientId,
        createdAt: createdAt ?? this.createdAt,
      );
  Connections copyWithCompanion(i1.ConnectionsCompanion data) {
    return Connections(
      id: data.id.present ? data.id.value : this.id,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      direction: data.direction.present ? data.direction.value : this.direction,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Connections(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('direction: $direction, ')
          ..write('clientId: $clientId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nickname, direction, clientId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Connections &&
          other.id == this.id &&
          other.nickname == this.nickname &&
          other.direction == this.direction &&
          other.clientId == this.clientId &&
          other.createdAt == this.createdAt);
}

class ConnectionsCompanion extends i0.UpdateCompanion<i1.Connections> {
  final i0.Value<String> id;
  final i0.Value<String> nickname;
  final i0.Value<String> direction;
  final i0.Value<String> clientId;
  final i0.Value<DateTime> createdAt;
  final i0.Value<int> rowid;
  const ConnectionsCompanion({
    this.id = const i0.Value.absent(),
    this.nickname = const i0.Value.absent(),
    this.direction = const i0.Value.absent(),
    this.clientId = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  ConnectionsCompanion.insert({
    required String id,
    required String nickname,
    required String direction,
    required String clientId,
    this.createdAt = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  })  : id = i0.Value(id),
        nickname = i0.Value(nickname),
        direction = i0.Value(direction),
        clientId = i0.Value(clientId);
  static i0.Insertable<i1.Connections> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? nickname,
    i0.Expression<String>? direction,
    i0.Expression<String>? clientId,
    i0.Expression<DateTime>? createdAt,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (nickname != null) 'nickname': nickname,
      if (direction != null) 'direction': direction,
      if (clientId != null) 'client_id': clientId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.ConnectionsCompanion copyWith(
      {i0.Value<String>? id,
      i0.Value<String>? nickname,
      i0.Value<String>? direction,
      i0.Value<String>? clientId,
      i0.Value<DateTime>? createdAt,
      i0.Value<int>? rowid}) {
    return i1.ConnectionsCompanion(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      direction: direction ?? this.direction,
      clientId: clientId ?? this.clientId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<String>(id.value);
    }
    if (nickname.present) {
      map['nickname'] = i0.Variable<String>(nickname.value);
    }
    if (direction.present) {
      map['direction'] = i0.Variable<String>(direction.value);
    }
    if (clientId.present) {
      map['client_id'] = i0.Variable<String>(clientId.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConnectionsCompanion(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('direction: $direction, ')
          ..write('clientId: $clientId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends i2.Settings
    with i0.TableInfo<$SettingsTable, i1.Settings> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _keyMeta = const i0.VerificationMeta('key');
  @override
  late final i0.GeneratedColumn<String> key = i0.GeneratedColumn<String>(
      'key', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _valueMeta =
      const i0.VerificationMeta('value');
  @override
  late final i0.GeneratedColumn<String> value = i0.GeneratedColumn<String>(
      'value', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _createdAtMeta =
      const i0.VerificationMeta('createdAt');
  @override
  late final i0.GeneratedColumn<DateTime> createdAt =
      i0.GeneratedColumn<DateTime>('created_at', aliasedName, false,
          type: i0.DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: i3.currentDateAndTime);
  @override
  List<i0.GeneratedColumn> get $columns => [key, value, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.Settings> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {key};
  @override
  i1.Settings map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Settings(
      key: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}value'])!,
      createdAt: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Settings extends i0.DataClass implements i0.Insertable<i1.Settings> {
  final String key;
  final String value;
  final DateTime createdAt;
  const Settings(
      {required this.key, required this.value, required this.createdAt});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['key'] = i0.Variable<String>(key);
    map['value'] = i0.Variable<String>(value);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    return map;
  }

  i1.SettingsCompanion toCompanion(bool nullToAbsent) {
    return i1.SettingsCompanion(
      key: i0.Value(key),
      value: i0.Value(value),
      createdAt: i0.Value(createdAt),
    );
  }

  factory Settings.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Settings(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  i1.Settings copyWith({String? key, String? value, DateTime? createdAt}) =>
      i1.Settings(
        key: key ?? this.key,
        value: value ?? this.value,
        createdAt: createdAt ?? this.createdAt,
      );
  Settings copyWithCompanion(i1.SettingsCompanion data) {
    return Settings(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Settings(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Settings &&
          other.key == this.key &&
          other.value == this.value &&
          other.createdAt == this.createdAt);
}

class SettingsCompanion extends i0.UpdateCompanion<i1.Settings> {
  final i0.Value<String> key;
  final i0.Value<String> value;
  final i0.Value<DateTime> createdAt;
  final i0.Value<int> rowid;
  const SettingsCompanion({
    this.key = const i0.Value.absent(),
    this.value = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    this.createdAt = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  })  : key = i0.Value(key),
        value = i0.Value(value);
  static i0.Insertable<i1.Settings> custom({
    i0.Expression<String>? key,
    i0.Expression<String>? value,
    i0.Expression<DateTime>? createdAt,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.SettingsCompanion copyWith(
      {i0.Value<String>? key,
      i0.Value<String>? value,
      i0.Value<DateTime>? createdAt,
      i0.Value<int>? rowid}) {
    return i1.SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (key.present) {
      map['key'] = i0.Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = i0.Variable<String>(value.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QueueTable extends i2.Queue with i0.TableInfo<$QueueTable, i1.Queue> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QueueTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<String> id = i0.GeneratedColumn<String>(
      'id', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _titleMeta =
      const i0.VerificationMeta('title');
  @override
  late final i0.GeneratedColumn<String> title = i0.GeneratedColumn<String>(
      'title', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _lyricsMeta =
      const i0.VerificationMeta('lyrics');
  @override
  late final i0.GeneratedColumn<String> lyrics = i0.GeneratedColumn<String>(
      'lyrics', aliasedName, true,
      type: i0.DriftSqlType.string, requiredDuringInsert: false);
  static const i0.VerificationMeta _tagsMeta =
      const i0.VerificationMeta('tags');
  @override
  late final i0.GeneratedColumn<String> tags = i0.GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _negativeTagsMeta =
      const i0.VerificationMeta('negativeTags');
  @override
  late final i0.GeneratedColumn<String> negativeTags =
      i0.GeneratedColumn<String>('negative_tags', aliasedName, true,
          type: i0.DriftSqlType.string, requiredDuringInsert: false);
  static const i0.VerificationMeta _inputFileMeta =
      const i0.VerificationMeta('inputFile');
  @override
  late final i0.GeneratedColumn<String> inputFile = i0.GeneratedColumn<String>(
      'input_file', aliasedName, true,
      type: i0.DriftSqlType.string, requiredDuringInsert: false);
  static const i0.VerificationMeta _modelMeta =
      const i0.VerificationMeta('model');
  @override
  late final i0.GeneratedColumn<String> model = i0.GeneratedColumn<String>(
      'model', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _clientRequestedIdMeta =
      const i0.VerificationMeta('clientRequestedId');
  @override
  late final i0.GeneratedColumn<String> clientRequestedId =
      i0.GeneratedColumn<String>('client_requested_id', aliasedName, false,
          type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _lrcPromptMeta =
      const i0.VerificationMeta('lrcPrompt');
  @override
  late final i0.GeneratedColumn<String> lrcPrompt = i0.GeneratedColumn<String>(
      'lrc_prompt', aliasedName, false,
      type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _processingStatusMeta =
      const i0.VerificationMeta('processingStatus');
  @override
  late final i0.GeneratedColumn<String> processingStatus =
      i0.GeneratedColumn<String>('processing_status', aliasedName, false,
          type: i0.DriftSqlType.string, requiredDuringInsert: true);
  static const i0.VerificationMeta _stepsMeta =
      const i0.VerificationMeta('steps');
  @override
  late final i0.GeneratedColumn<int> steps = i0.GeneratedColumn<int>(
      'steps', aliasedName, false,
      type: i0.DriftSqlType.int, requiredDuringInsert: true);
  static const i0.VerificationMeta _cfgStrengthMeta =
      const i0.VerificationMeta('cfgStrength');
  @override
  late final i0.GeneratedColumn<int> cfgStrength = i0.GeneratedColumn<int>(
      'cfg_strength', aliasedName, false,
      type: i0.DriftSqlType.int, requiredDuringInsert: true);
  static const i0.VerificationMeta _durationMeta =
      const i0.VerificationMeta('duration');
  @override
  late final i0.GeneratedColumn<int> duration = i0.GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: i0.DriftSqlType.int, requiredDuringInsert: true);
  static const i0.VerificationMeta _isFavoriteMeta =
      const i0.VerificationMeta('isFavorite');
  @override
  late final i0.GeneratedColumn<bool> isFavorite = i0.GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: i0.DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
          'CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const i3.Constant(false));
  static const i0.VerificationMeta _isDeletedMeta =
      const i0.VerificationMeta('isDeleted');
  @override
  late final i0.GeneratedColumn<bool> isDeleted = i0.GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: i0.DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
          'CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const i3.Constant(false));
  static const i0.VerificationMeta _createdAtMeta =
      const i0.VerificationMeta('createdAt');
  @override
  late final i0.GeneratedColumn<DateTime> createdAt =
      i0.GeneratedColumn<DateTime>('created_at', aliasedName, false,
          type: i0.DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: i3.currentDateAndTime);
  @override
  List<i0.GeneratedColumn> get $columns => [
        id,
        title,
        lyrics,
        tags,
        negativeTags,
        inputFile,
        model,
        clientRequestedId,
        lrcPrompt,
        processingStatus,
        steps,
        cfgStrength,
        duration,
        isFavorite,
        isDeleted,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'queue';
  @override
  i0.VerificationContext validateIntegrity(i0.Insertable<i1.Queue> instance,
      {bool isInserting = false}) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('lyrics')) {
      context.handle(_lyricsMeta,
          lyrics.isAcceptableOrUnknown(data['lyrics']!, _lyricsMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    if (data.containsKey('negative_tags')) {
      context.handle(
          _negativeTagsMeta,
          negativeTags.isAcceptableOrUnknown(
              data['negative_tags']!, _negativeTagsMeta));
    }
    if (data.containsKey('input_file')) {
      context.handle(_inputFileMeta,
          inputFile.isAcceptableOrUnknown(data['input_file']!, _inputFileMeta));
    }
    if (data.containsKey('model')) {
      context.handle(
          _modelMeta, model.isAcceptableOrUnknown(data['model']!, _modelMeta));
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('client_requested_id')) {
      context.handle(
          _clientRequestedIdMeta,
          clientRequestedId.isAcceptableOrUnknown(
              data['client_requested_id']!, _clientRequestedIdMeta));
    } else if (isInserting) {
      context.missing(_clientRequestedIdMeta);
    }
    if (data.containsKey('lrc_prompt')) {
      context.handle(_lrcPromptMeta,
          lrcPrompt.isAcceptableOrUnknown(data['lrc_prompt']!, _lrcPromptMeta));
    } else if (isInserting) {
      context.missing(_lrcPromptMeta);
    }
    if (data.containsKey('processing_status')) {
      context.handle(
          _processingStatusMeta,
          processingStatus.isAcceptableOrUnknown(
              data['processing_status']!, _processingStatusMeta));
    } else if (isInserting) {
      context.missing(_processingStatusMeta);
    }
    if (data.containsKey('steps')) {
      context.handle(
          _stepsMeta, steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta));
    } else if (isInserting) {
      context.missing(_stepsMeta);
    }
    if (data.containsKey('cfg_strength')) {
      context.handle(
          _cfgStrengthMeta,
          cfgStrength.isAcceptableOrUnknown(
              data['cfg_strength']!, _cfgStrengthMeta));
    } else if (isInserting) {
      context.missing(_cfgStrengthMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Queue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Queue(
      id: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}title'])!,
      lyrics: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}lyrics']),
      tags: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}tags'])!,
      negativeTags: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}negative_tags']),
      inputFile: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}input_file']),
      model: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}model'])!,
      clientRequestedId: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string,
          data['${effectivePrefix}client_requested_id'])!,
      lrcPrompt: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.string, data['${effectivePrefix}lrc_prompt'])!,
      processingStatus: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string, data['${effectivePrefix}processing_status'])!,
      steps: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}steps'])!,
      cfgStrength: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}cfg_strength'])!,
      duration: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.int, data['${effectivePrefix}duration'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(i0.DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping.read(
          i0.DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $QueueTable createAlias(String alias) {
    return $QueueTable(attachedDatabase, alias);
  }
}

class Queue extends i0.DataClass implements i0.Insertable<i1.Queue> {
  final String id;
  final String title;
  final String? lyrics;
  final String tags;
  final String? negativeTags;
  final String? inputFile;
  final String model;
  final String clientRequestedId;
  final String lrcPrompt;
  final String processingStatus;
  final int steps;
  final int cfgStrength;
  final int duration;
  final bool isFavorite;
  final bool isDeleted;
  final DateTime createdAt;
  const Queue(
      {required this.id,
      required this.title,
      this.lyrics,
      required this.tags,
      this.negativeTags,
      this.inputFile,
      required this.model,
      required this.clientRequestedId,
      required this.lrcPrompt,
      required this.processingStatus,
      required this.steps,
      required this.cfgStrength,
      required this.duration,
      required this.isFavorite,
      required this.isDeleted,
      required this.createdAt});
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<String>(id);
    map['title'] = i0.Variable<String>(title);
    if (!nullToAbsent || lyrics != null) {
      map['lyrics'] = i0.Variable<String>(lyrics);
    }
    map['tags'] = i0.Variable<String>(tags);
    if (!nullToAbsent || negativeTags != null) {
      map['negative_tags'] = i0.Variable<String>(negativeTags);
    }
    if (!nullToAbsent || inputFile != null) {
      map['input_file'] = i0.Variable<String>(inputFile);
    }
    map['model'] = i0.Variable<String>(model);
    map['client_requested_id'] = i0.Variable<String>(clientRequestedId);
    map['lrc_prompt'] = i0.Variable<String>(lrcPrompt);
    map['processing_status'] = i0.Variable<String>(processingStatus);
    map['steps'] = i0.Variable<int>(steps);
    map['cfg_strength'] = i0.Variable<int>(cfgStrength);
    map['duration'] = i0.Variable<int>(duration);
    map['is_favorite'] = i0.Variable<bool>(isFavorite);
    map['is_deleted'] = i0.Variable<bool>(isDeleted);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    return map;
  }

  i1.QueueCompanion toCompanion(bool nullToAbsent) {
    return i1.QueueCompanion(
      id: i0.Value(id),
      title: i0.Value(title),
      lyrics: lyrics == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(lyrics),
      tags: i0.Value(tags),
      negativeTags: negativeTags == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(negativeTags),
      inputFile: inputFile == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(inputFile),
      model: i0.Value(model),
      clientRequestedId: i0.Value(clientRequestedId),
      lrcPrompt: i0.Value(lrcPrompt),
      processingStatus: i0.Value(processingStatus),
      steps: i0.Value(steps),
      cfgStrength: i0.Value(cfgStrength),
      duration: i0.Value(duration),
      isFavorite: i0.Value(isFavorite),
      isDeleted: i0.Value(isDeleted),
      createdAt: i0.Value(createdAt),
    );
  }

  factory Queue.fromJson(Map<String, dynamic> json,
      {i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Queue(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      lyrics: serializer.fromJson<String?>(json['lyrics']),
      tags: serializer.fromJson<String>(json['tags']),
      negativeTags: serializer.fromJson<String?>(json['negativeTags']),
      inputFile: serializer.fromJson<String?>(json['inputFile']),
      model: serializer.fromJson<String>(json['model']),
      clientRequestedId: serializer.fromJson<String>(json['clientRequestedId']),
      lrcPrompt: serializer.fromJson<String>(json['lrcPrompt']),
      processingStatus: serializer.fromJson<String>(json['processingStatus']),
      steps: serializer.fromJson<int>(json['steps']),
      cfgStrength: serializer.fromJson<int>(json['cfgStrength']),
      duration: serializer.fromJson<int>(json['duration']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'lyrics': serializer.toJson<String?>(lyrics),
      'tags': serializer.toJson<String>(tags),
      'negativeTags': serializer.toJson<String?>(negativeTags),
      'inputFile': serializer.toJson<String?>(inputFile),
      'model': serializer.toJson<String>(model),
      'clientRequestedId': serializer.toJson<String>(clientRequestedId),
      'lrcPrompt': serializer.toJson<String>(lrcPrompt),
      'processingStatus': serializer.toJson<String>(processingStatus),
      'steps': serializer.toJson<int>(steps),
      'cfgStrength': serializer.toJson<int>(cfgStrength),
      'duration': serializer.toJson<int>(duration),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  i1.Queue copyWith(
          {String? id,
          String? title,
          i0.Value<String?> lyrics = const i0.Value.absent(),
          String? tags,
          i0.Value<String?> negativeTags = const i0.Value.absent(),
          i0.Value<String?> inputFile = const i0.Value.absent(),
          String? model,
          String? clientRequestedId,
          String? lrcPrompt,
          String? processingStatus,
          int? steps,
          int? cfgStrength,
          int? duration,
          bool? isFavorite,
          bool? isDeleted,
          DateTime? createdAt}) =>
      i1.Queue(
        id: id ?? this.id,
        title: title ?? this.title,
        lyrics: lyrics.present ? lyrics.value : this.lyrics,
        tags: tags ?? this.tags,
        negativeTags:
            negativeTags.present ? negativeTags.value : this.negativeTags,
        inputFile: inputFile.present ? inputFile.value : this.inputFile,
        model: model ?? this.model,
        clientRequestedId: clientRequestedId ?? this.clientRequestedId,
        lrcPrompt: lrcPrompt ?? this.lrcPrompt,
        processingStatus: processingStatus ?? this.processingStatus,
        steps: steps ?? this.steps,
        cfgStrength: cfgStrength ?? this.cfgStrength,
        duration: duration ?? this.duration,
        isFavorite: isFavorite ?? this.isFavorite,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
      );
  Queue copyWithCompanion(i1.QueueCompanion data) {
    return Queue(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      lyrics: data.lyrics.present ? data.lyrics.value : this.lyrics,
      tags: data.tags.present ? data.tags.value : this.tags,
      negativeTags: data.negativeTags.present
          ? data.negativeTags.value
          : this.negativeTags,
      inputFile: data.inputFile.present ? data.inputFile.value : this.inputFile,
      model: data.model.present ? data.model.value : this.model,
      clientRequestedId: data.clientRequestedId.present
          ? data.clientRequestedId.value
          : this.clientRequestedId,
      lrcPrompt: data.lrcPrompt.present ? data.lrcPrompt.value : this.lrcPrompt,
      processingStatus: data.processingStatus.present
          ? data.processingStatus.value
          : this.processingStatus,
      steps: data.steps.present ? data.steps.value : this.steps,
      cfgStrength:
          data.cfgStrength.present ? data.cfgStrength.value : this.cfgStrength,
      duration: data.duration.present ? data.duration.value : this.duration,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Queue(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('lyrics: $lyrics, ')
          ..write('tags: $tags, ')
          ..write('negativeTags: $negativeTags, ')
          ..write('inputFile: $inputFile, ')
          ..write('model: $model, ')
          ..write('clientRequestedId: $clientRequestedId, ')
          ..write('lrcPrompt: $lrcPrompt, ')
          ..write('processingStatus: $processingStatus, ')
          ..write('steps: $steps, ')
          ..write('cfgStrength: $cfgStrength, ')
          ..write('duration: $duration, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      lyrics,
      tags,
      negativeTags,
      inputFile,
      model,
      clientRequestedId,
      lrcPrompt,
      processingStatus,
      steps,
      cfgStrength,
      duration,
      isFavorite,
      isDeleted,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Queue &&
          other.id == this.id &&
          other.title == this.title &&
          other.lyrics == this.lyrics &&
          other.tags == this.tags &&
          other.negativeTags == this.negativeTags &&
          other.inputFile == this.inputFile &&
          other.model == this.model &&
          other.clientRequestedId == this.clientRequestedId &&
          other.lrcPrompt == this.lrcPrompt &&
          other.processingStatus == this.processingStatus &&
          other.steps == this.steps &&
          other.cfgStrength == this.cfgStrength &&
          other.duration == this.duration &&
          other.isFavorite == this.isFavorite &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt);
}

class QueueCompanion extends i0.UpdateCompanion<i1.Queue> {
  final i0.Value<String> id;
  final i0.Value<String> title;
  final i0.Value<String?> lyrics;
  final i0.Value<String> tags;
  final i0.Value<String?> negativeTags;
  final i0.Value<String?> inputFile;
  final i0.Value<String> model;
  final i0.Value<String> clientRequestedId;
  final i0.Value<String> lrcPrompt;
  final i0.Value<String> processingStatus;
  final i0.Value<int> steps;
  final i0.Value<int> cfgStrength;
  final i0.Value<int> duration;
  final i0.Value<bool> isFavorite;
  final i0.Value<bool> isDeleted;
  final i0.Value<DateTime> createdAt;
  final i0.Value<int> rowid;
  const QueueCompanion({
    this.id = const i0.Value.absent(),
    this.title = const i0.Value.absent(),
    this.lyrics = const i0.Value.absent(),
    this.tags = const i0.Value.absent(),
    this.negativeTags = const i0.Value.absent(),
    this.inputFile = const i0.Value.absent(),
    this.model = const i0.Value.absent(),
    this.clientRequestedId = const i0.Value.absent(),
    this.lrcPrompt = const i0.Value.absent(),
    this.processingStatus = const i0.Value.absent(),
    this.steps = const i0.Value.absent(),
    this.cfgStrength = const i0.Value.absent(),
    this.duration = const i0.Value.absent(),
    this.isFavorite = const i0.Value.absent(),
    this.isDeleted = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  });
  QueueCompanion.insert({
    required String id,
    required String title,
    this.lyrics = const i0.Value.absent(),
    required String tags,
    this.negativeTags = const i0.Value.absent(),
    this.inputFile = const i0.Value.absent(),
    required String model,
    required String clientRequestedId,
    required String lrcPrompt,
    required String processingStatus,
    required int steps,
    required int cfgStrength,
    required int duration,
    this.isFavorite = const i0.Value.absent(),
    this.isDeleted = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
    this.rowid = const i0.Value.absent(),
  })  : id = i0.Value(id),
        title = i0.Value(title),
        tags = i0.Value(tags),
        model = i0.Value(model),
        clientRequestedId = i0.Value(clientRequestedId),
        lrcPrompt = i0.Value(lrcPrompt),
        processingStatus = i0.Value(processingStatus),
        steps = i0.Value(steps),
        cfgStrength = i0.Value(cfgStrength),
        duration = i0.Value(duration);
  static i0.Insertable<i1.Queue> custom({
    i0.Expression<String>? id,
    i0.Expression<String>? title,
    i0.Expression<String>? lyrics,
    i0.Expression<String>? tags,
    i0.Expression<String>? negativeTags,
    i0.Expression<String>? inputFile,
    i0.Expression<String>? model,
    i0.Expression<String>? clientRequestedId,
    i0.Expression<String>? lrcPrompt,
    i0.Expression<String>? processingStatus,
    i0.Expression<int>? steps,
    i0.Expression<int>? cfgStrength,
    i0.Expression<int>? duration,
    i0.Expression<bool>? isFavorite,
    i0.Expression<bool>? isDeleted,
    i0.Expression<DateTime>? createdAt,
    i0.Expression<int>? rowid,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (lyrics != null) 'lyrics': lyrics,
      if (tags != null) 'tags': tags,
      if (negativeTags != null) 'negative_tags': negativeTags,
      if (inputFile != null) 'input_file': inputFile,
      if (model != null) 'model': model,
      if (clientRequestedId != null) 'client_requested_id': clientRequestedId,
      if (lrcPrompt != null) 'lrc_prompt': lrcPrompt,
      if (processingStatus != null) 'processing_status': processingStatus,
      if (steps != null) 'steps': steps,
      if (cfgStrength != null) 'cfg_strength': cfgStrength,
      if (duration != null) 'duration': duration,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  i1.QueueCompanion copyWith(
      {i0.Value<String>? id,
      i0.Value<String>? title,
      i0.Value<String?>? lyrics,
      i0.Value<String>? tags,
      i0.Value<String?>? negativeTags,
      i0.Value<String?>? inputFile,
      i0.Value<String>? model,
      i0.Value<String>? clientRequestedId,
      i0.Value<String>? lrcPrompt,
      i0.Value<String>? processingStatus,
      i0.Value<int>? steps,
      i0.Value<int>? cfgStrength,
      i0.Value<int>? duration,
      i0.Value<bool>? isFavorite,
      i0.Value<bool>? isDeleted,
      i0.Value<DateTime>? createdAt,
      i0.Value<int>? rowid}) {
    return i1.QueueCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      lyrics: lyrics ?? this.lyrics,
      tags: tags ?? this.tags,
      negativeTags: negativeTags ?? this.negativeTags,
      inputFile: inputFile ?? this.inputFile,
      model: model ?? this.model,
      clientRequestedId: clientRequestedId ?? this.clientRequestedId,
      lrcPrompt: lrcPrompt ?? this.lrcPrompt,
      processingStatus: processingStatus ?? this.processingStatus,
      steps: steps ?? this.steps,
      cfgStrength: cfgStrength ?? this.cfgStrength,
      duration: duration ?? this.duration,
      isFavorite: isFavorite ?? this.isFavorite,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = i0.Variable<String>(title.value);
    }
    if (lyrics.present) {
      map['lyrics'] = i0.Variable<String>(lyrics.value);
    }
    if (tags.present) {
      map['tags'] = i0.Variable<String>(tags.value);
    }
    if (negativeTags.present) {
      map['negative_tags'] = i0.Variable<String>(negativeTags.value);
    }
    if (inputFile.present) {
      map['input_file'] = i0.Variable<String>(inputFile.value);
    }
    if (model.present) {
      map['model'] = i0.Variable<String>(model.value);
    }
    if (clientRequestedId.present) {
      map['client_requested_id'] = i0.Variable<String>(clientRequestedId.value);
    }
    if (lrcPrompt.present) {
      map['lrc_prompt'] = i0.Variable<String>(lrcPrompt.value);
    }
    if (processingStatus.present) {
      map['processing_status'] = i0.Variable<String>(processingStatus.value);
    }
    if (steps.present) {
      map['steps'] = i0.Variable<int>(steps.value);
    }
    if (cfgStrength.present) {
      map['cfg_strength'] = i0.Variable<int>(cfgStrength.value);
    }
    if (duration.present) {
      map['duration'] = i0.Variable<int>(duration.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = i0.Variable<bool>(isFavorite.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = i0.Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = i0.Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QueueCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('lyrics: $lyrics, ')
          ..write('tags: $tags, ')
          ..write('negativeTags: $negativeTags, ')
          ..write('inputFile: $inputFile, ')
          ..write('model: $model, ')
          ..write('clientRequestedId: $clientRequestedId, ')
          ..write('lrcPrompt: $lrcPrompt, ')
          ..write('processingStatus: $processingStatus, ')
          ..write('steps: $steps, ')
          ..write('cfgStrength: $cfgStrength, ')
          ..write('duration: $duration, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}
