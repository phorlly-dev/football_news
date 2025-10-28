import 'package:flutter/material.dart';
import 'package:football_news/core/configs/router.dart';
import 'package:football_news/ui/components/layout.dart';

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
    await Future.delayed(Duration(milliseconds: 360));
    MyRouter.appReady.value = true;
    // await analytics.logAppOpen();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [CircularProgressIndicator(), Text('Loading...')],
        ),
      ),
    );
  }
}
