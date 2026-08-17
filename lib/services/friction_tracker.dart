import 'dart:async';

import 'package:flutter/foundation.dart';

class FrictionTracker {
  Timer? _timer;

  bool _hasTriggered = false;

  void start({
    required String fieldName,
  }) {
    _timer?.cancel();

    _hasTriggered = false;

    _timer = Timer(
      const Duration(seconds: 5),
          () {
        if (_hasTriggered) {
          return;
        }

        _hasTriggered = true;

        final timestamp =
        DateTime.now().toUtc().toIso8601String();

        debugPrint(
          '[UI_FRICTION_LOG] '
              'Timestamp: $timestamp | '
              'Field: $fieldName | '
              'Hesitation Duration: 5.0s',
        );
      },
    );
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    stop();
  }
}