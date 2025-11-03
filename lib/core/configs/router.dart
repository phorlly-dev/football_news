import 'package:flutter/material.dart';
import 'package:football_news/core/configs/routes.dart';
import 'package:football_news/core/controllers/auth_controller.dart';
import 'package:football_news/core/utils/route_persistence.dart';
import 'package:football_news/core/utils/router_refresh_stream.dart';
import 'package:football_news/ui/pages/app.dart';
import 'package:football_news/ui/pages/auth.dart';
import 'package:football_news/ui/partials/fixtures.dart';
import 'package:football_news/ui/partials/home.dart';
import 'package:football_news/ui/pages/splash.dart';
import 'package:football_news/ui/partials/settings.dart';
import 'package:football_news/ui/partials/standings.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  AppRouter._();
  static const url = 'https://bubble-blast-shooter.vercel.app';
  static final appReady = ValueNotifier<bool>(false);
  static final rootNavKey = GlobalKey<NavigatorState>();
  static final auth = Get.find<AuthController>();

  static Future<String> getInitialLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_route') ?? Routes.home.path;
  }

  static GoRouter get router => GoRouter(
    observers: [RoutePersistence()],
    navigatorKey: rootNavKey,
    initialLocation: Routes.splash.path,
    refreshListenable: GoRouterRefreshStream(auth.firebaseUser.stream),
    redirect: (context, state) {
      final user = auth.firebaseUser.value;
      final goingTo = state.matchedLocation;

      if (user == null && goingTo != Routes.auth.path) {
        return Routes.auth.path;
      }

      if (user != null &&
          (goingTo == Routes.auth.path || goingTo == Routes.splash.path)) {
        return Routes.home.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: Routes.splash.path,
        name: Routes.splash.name,
        builder: (ctx, st) => const Splash(),
      ),
      GoRoute(
        path: Routes.auth.path,
        name: Routes.auth.name,
        builder: (ctx, st) => Auth(controller: auth),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppLayout(child: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home.path,
                name: Routes.home.name,
                pageBuilder: (ctx, st) {
                  return NoTransitionPage(child: const Home());
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.fixtures.path,
                name: Routes.fixtures.name,
                pageBuilder: (ctx, st) {
                  return NoTransitionPage(child: const Fixtures());
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.standings.path,
                name: Routes.standings.name,
                pageBuilder: (ctx, st) {
                  return NoTransitionPage(child: const Standings());
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.settings.path,
                name: Routes.settings.name,
                pageBuilder: (ctx, st) {
                  return NoTransitionPage(child: Settings());
                },
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (ctx, st) {
      return Scaffold(
        body: Center(child: Text('No route for: ${st.uri.toString()}')),
      );
    },
    // extraCodec: CustomCodec(),
  );
}
