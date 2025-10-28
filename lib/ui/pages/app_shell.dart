import 'package:flutter/material.dart';
import 'package:football_news/core/controllers/auth_controller.dart';
import 'package:football_news/ui/pages/auth.dart';
import 'package:football_news/ui/pages/home.dart';
import 'package:get/get.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AuthController>();

    return Obx(() {
      final user = ctrl.firebaseUser.value;

      if (user == null) {
        return Auth(controller: ctrl); // show login screen
      } else {
        return const Home(); // your main app
      }
    });
  }
}
