import 'package:logger/logger.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void diskRotNetworkBackgroundTask() {
  Workmanager().executeTask((task, inputData) async {
    final logger = Logger();

    logger.i("Diskrot background task running: $task");

    try {
      logger.i("Diskrot background task completed successfully");
    } catch (err) {
      logger.e("Background task failed");
      return Future.value(false);
    }

    return Future.value(true);
  });
}
