import 'package:flutter/material.dart';
import 'package:football_news/core/controllers/auth_controller.dart';
import 'package:football_news/ui/components/button.dart';
import 'package:football_news/ui/components/layout.dart';
import 'package:football_news/ui/components/nav_bar.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      header: NavBar(title: "Home"),
      content: Column(
        children: [
          MyButton(
            icon: Icons.logout_rounded,
            label: 'Sign Out',
            onPressed: () => Get.find<AuthController>().signOut(),
          ),
          // MyButton(
          //   icon: Icons.logout_rounded,
          //   label: 'Sign Out',
          //   onPressed: () => Get.find<AuthController>().signOut(),
          // ),
          Center(child: Text("Welcome")),
        ],
      ),
    );
  }
}
