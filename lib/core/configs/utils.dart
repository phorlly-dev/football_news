import 'dart:async';

import 'package:flutter/material.dart';

class Utils {
  static void guarded({
    required void Function() callback,
    void Function(Object, StackTrace)? onError,
  }) {
    runZonedGuarded(
      callback,
      onError ??
          (error, stack) {
            debugPrint('⚠️ Caught error in guarded zone:\n$error\n$stack');
          },
    );
  }
}
