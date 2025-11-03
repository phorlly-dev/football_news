import 'package:flutter/material.dart';
import 'package:football_news/core/configs/router.dart';
import 'package:football_news/ui/components/layout.dart';
import 'package:football_news/ui/components/loading.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    await Future.delayed(Duration(milliseconds: 600));
    AppRouter.appReady.value = true;
    // await analytics.logAppOpen();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(content: Loading(title: 'LiveScore'));
  }
}
