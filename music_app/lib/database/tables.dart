import 'package:drift/drift.dart';

@DataClassName('Music')
class Music extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get lyrics => text()();
  TextColumn get tags => text()();
  TextColumn get negativeTags => text()();
  TextColumn get inputFile => text()();
  TextColumn get model => text()();
  TextColumn get clientProcessingId => text()();
  TextColumn get lrcPrompt => text()();
  TextColumn get processingStatus => text()();
  IntColumn get steps => integer()();
  IntColumn get cfgStrength => integer()();
  IntColumn get duration => integer()();
  BoolColumn get isFavorite => boolean()();
  BoolColumn get isDeleted => boolean()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Prompt')
class Prompt extends Table {
  TextColumn get id => text()();
  TextColumn get prompt => text()();
  TextColumn get category => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Invitations')
class Invitations extends Table {
  TextColumn get id => text()();
  TextColumn get clientAcceptedId => text().nullable()();
  TextColumn get code => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Connections')
class Connections extends Table {
  TextColumn get id => text()();
  TextColumn get nickname => text()();
  TextColumn get direction => text()();
  TextColumn get clientId => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Settings')
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {key};
}

@DataClassName('Queue')
class Queue extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get lyrics => text().nullable()();
  TextColumn get tags => text()();
  TextColumn get negativeTags => text().nullable()();
  TextColumn get inputFile => text().nullable()();
  TextColumn get model => text()();
  TextColumn get clientRequestedId => text()();
  TextColumn get lrcPrompt => text()();
  TextColumn get processingStatus => text()();
  IntColumn get steps => integer()();
  IntColumn get cfgStrength => integer()();
  IntColumn get duration => integer()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
