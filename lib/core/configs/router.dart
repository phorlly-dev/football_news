import 'package:flutter/material.dart';
import 'package:football_news/ui/pages/app_shell.dart';
import 'package:football_news/ui/pages/home.dart';
import 'package:football_news/ui/pages/splash.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  static const url = 'https://bubble-blast-shooter.vercel.app';
  static final appReady = ValueNotifier<bool>(false);
  static final rootNavKey = GlobalKey<NavigatorState>();
  static GoRouter get router => GoRouter(
    // observers: [AnalyticsObserver()],
    navigatorKey: rootNavKey,

    // debugLogDiagnostics: true,
    initialLocation: '/splash',

    // Whenever appReady changes, re-run redirect logic
    refreshListenable: appReady,

    // Global redirect (replace your GetMiddleware)
    redirect: (context, state) {
      final goingTo = state.matchedLocation;
      if (!appReady.value && goingTo != '/splash') return '/splash';
      if (appReady.value && (goingTo == '/' || goingTo == '/splash')) {
        return '/app-shell';
      }

      return null; // no redirect
    },
    routes: [
      // Simple pages
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (ctx, st) => const Splash(),
      ),
      GoRoute(path: '/home', name: 'home', builder: (ctx, st) => const Home()),

      GoRoute(
        path: '/app-shell',
        name: 'app_shell',
        builder: (ctx, st) => const AppShell(),
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
