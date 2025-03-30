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
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('Prompt')
class Prompt extends Table {
  TextColumn get id => text()();
  TextColumn get prompt => text()();
  TextColumn get category => text()();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('Client')
class Client extends Table {
  TextColumn get id => text()();
  TextColumn get nickname => text()();
  TextColumn get sharedSecret => text()();
  BoolColumn get isExternal => boolean()();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('Invitations')
class Invitations extends Table {
  TextColumn get id => text()();
  TextColumn get clientAcceptedId => text()();
  TextColumn get code => text()();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('Connections')
class Connections extends Table {
  TextColumn get id => text()();
  TextColumn get nickname => text()();
  TextColumn get direction => text()();
  TextColumn get clientId => text()();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('Settings')
class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
}

@DataClassName('Queue')
class Queue extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get lyrics => text()();
  TextColumn get tags => text()();
  TextColumn get negativeTags => text()();
  TextColumn get inputFile => text()();
  TextColumn get model => text()();
  TextColumn get clientRequestedId => text()();
  TextColumn get lrcPrompt => text()();
  TextColumn get processingStatus => text()();
  IntColumn get steps => integer()();
  IntColumn get cfgStrength => integer()();
  IntColumn get duration => integer()();
  BoolColumn get isFavorite => boolean()();
  BoolColumn get isDeleted => boolean()();
  DateTimeColumn get createdAt => dateTime()();
}
