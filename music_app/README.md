# music_app

A new Flutter project.

## Build Database


```bash
dart run build_runner build
dart run drift_dev schema dump lib/database/database.dart drift_schemas/
dart run drift_dev schema steps drift_schemas/ lib/database/schema_versions.dart
dart run drift_dev schema generate drift_schemas/ test/generated_migrations/
```


