import 'package:flutter/material.dart';

enum MessageType { info, error, success }

class MySnackBar {
  MySnackBar._();
  static void show(
    BuildContext context, {
    required String message,
    MessageType type = MessageType.info,
    double textSize = 16,
    int timer = 3,
  }) {
    custom(
      context,
      message: message,
      bg: getColor(type),
      fontSize: textSize,
      timer: timer,
    );
  }

  static Color? getColor(MessageType type) {
    var color = Colors.blueAccent[400];

    switch (type) {
      case MessageType.success:
        color = Colors.lightGreen[800];
        break;

      case MessageType.error:
        color = Colors.redAccent[400];
        break;

      default:
        color;
    }

    return color;
  }

  static void custom(
    BuildContext context, {
    required String message,
    Color? bg,
    required double fontSize,
    required int timer,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
        backgroundColor: bg,
        duration: Duration(seconds: timer),
      ),
    );
  }
}
