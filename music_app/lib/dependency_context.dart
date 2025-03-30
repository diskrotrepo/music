import 'package:get_it/get_it.dart' hide Disposable;
import 'package:music_app/database/database.dart';

DependencyContext get dependencyContext => DependencyContext.instance;

class DependencyContext {
  DependencyContext() : getIt = _setup();

  static final instance = DependencyContext();

  late GetIt getIt;

  static GetIt _setup() {
    final getIt = GetIt.instance;

    return getIt
      ..registerLazySingleton<AppDatabase>(
        AppDatabase.new,
        dispose: (database) => database.close(),
      );
  }

  Future<void> allReady() async {
    await getIt.allReady();
  }
}
