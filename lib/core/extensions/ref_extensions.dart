import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RefExtension on Ref {
  /// Keeps the provider alive for [duration] after the last listener is removed.
  /// Once the duration expires, the provider is disposed and will be re-evaluated
  /// the next time it's read or listened to.
  void cacheFor(Duration duration) {
    final link = keepAlive();
    Timer? timer;

    onDispose(() {
      timer?.cancel();
    });

    onCancel(() {
      timer = Timer(duration, () {
        link.close();
      });
    });

    onResume(() {
      timer?.cancel();
    });
  }
}
