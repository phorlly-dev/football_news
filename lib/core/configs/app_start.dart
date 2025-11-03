import 'package:flutter/material.dart';
import 'package:football_news/core/configs/router.dart';
import 'package:football_news/core/utils/theme_manager.dart';
import 'package:football_news/ui/themes/theme_app.dart';
import 'package:provider/provider.dart';

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Football News',
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
      darkTheme: ThemeData.dark(),
      themeMode: context.watch<ThemeManager>().themeMode,
      routerConfig: AppRouter.router,
    );
  }
}
