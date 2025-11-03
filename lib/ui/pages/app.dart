import 'package:flutter/material.dart';
import 'package:football_news/core/configs/routes.dart';
import 'package:football_news/core/utils/app_assets.dart';
import 'package:football_news/core/utils/app_strings.dart';
import 'package:football_news/core/extensions/nums.dart';
import 'package:football_news/ui/components/custom_image.dart';
import 'package:football_news/ui/components/layout.dart';
import 'package:football_news/ui/components/nav_bar.dart';
import 'package:go_router/go_router.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  const AppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;

    return Layout(
      header: NavBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImage(imageUrl: AppAssets.appLogo, height: 60.height),
            Text(
              AppStrings.bottomNavTitles[Routes.currentIndex(location)],
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
      content: child,
      footer: BottomNavigationBar(
        currentIndex: Routes.currentIndex(location),
        onTap: (index) {
          final router = GoRouter.of(context);
          final target = switch (index) {
            1 => Routes.fixtures.path,
            2 => Routes.standings.path,
            3 => Routes.settings.path,
            _ => Routes.home.path,
          };

          router.go(target);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer_rounded),
            label: AppStrings.fixtures,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: AppStrings.standings,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppStrings.settings,
          ),
        ],
      ),
    );
  }
}
