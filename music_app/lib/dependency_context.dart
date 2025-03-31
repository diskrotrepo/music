import 'package:get_it/get_it.dart' hide Disposable;
import 'package:logger/logger.dart';
import 'package:music_app/create/create_controller.dart';
import 'package:music_app/create/create_repository.dart';
import 'package:music_app/database/database.dart';
import 'package:music_app/home/home_controller.dart';
import 'package:music_app/library/library_controller.dart';
import 'package:music_app/library/library_repository.dart';
import 'package:music_app/network/network_controller.dart';
import 'package:music_app/network/network_repository.dart';
import 'package:music_app/settings/settings_controller.dart';
import 'package:music_app/settings/settings_repository.dart';

final di = GetIt.I;

GetIt setup() {
  return di
    ..registerLazySingleton<AppDatabase>(
      AppDatabase.new,
      dispose: (database) => database.close(),
    )
    ..registerLazySingleton<Logger>(
      () => Logger(
        printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
        ),
      ),
    )
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepository(database: di.get<AppDatabase>()),
    )
    ..registerLazySingleton<LibraryRepository>(
      () => LibraryRepository(database: di.get<AppDatabase>()),
    )
    ..registerLazySingleton<NetworkRepository>(
      () => NetworkRepository(database: di.get<AppDatabase>()),
    )
    ..registerLazySingleton<CreateRepository>(
      () => CreateRepository(database: di.get<AppDatabase>()),
    )
    ..registerLazySingleton(() =>
        SettingsController(settingsRepository: di.get<SettingsRepository>()))
    ..registerLazySingleton(() => HomeController())
    ..registerLazySingleton(
        () => LibraryController(libraryRepository: di.get<LibraryRepository>()))
    ..registerLazySingleton(
        () => CreateController(createRepository: di.get<CreateRepository>()))
    ..registerLazySingleton(() =>
        NetworkController(networkRepository: di.get<NetworkRepository>()));
}
