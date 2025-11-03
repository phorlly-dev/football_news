import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  Utils._();
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

  static String dateToTime(DateTime date, [String? format]) {
    final local = date.toLocal();
    final utc = date.toUtc();

    return '${DateFormat('h:mm a').format(local)} (Local) • ${DateFormat('HH:mm').format(utc)} UTC';
  }
}
