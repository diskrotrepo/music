import 'dart:async';

Future<void> diskRotBackgroundWorker(int timer) async {
  Timer.periodic(const Duration(seconds: 1), (Timer t) {
    print("Disk rotation task running in background...");
  });
}
