import 'package:logger/logger.dart';
import 'package:music_app/database/database.dart';
import 'package:music_app/dependency_context.dart';

class NetworkRepository {
  NetworkRepository({required AppDatabase database}) : _database = database;
  final AppDatabase _database;
  final Logger _logger = di.get<Logger>();
}
