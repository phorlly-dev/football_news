import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_news/core/configs/app_start.dart';
import 'package:football_news/core/backups/league_controller.dart';
import 'package:football_news/core/controllers/fixture_controller.dart';
import 'package:football_news/core/utils/utils.dart';
import 'package:football_news/core/configs/firebase_options.dart';
import 'package:football_news/core/controllers/auth_controller.dart';
import 'package:football_news/core/backups/matches_controller.dart';
import 'package:football_news/core/utils/theme_manager.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class Configure {
  Configure._();
  static late FirebaseApp app;
  static late FirebaseAuth auth;
  static final signIn = GoogleSignIn.instance;

  static void appConfig() {
    BindingBase.debugZoneErrorsAreFatal = true;

    Utils.guarded(
      callback: () async {
        // Must be FIRST inside the zone:
        WidgetsFlutterBinding.ensureInitialized();

        app = await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        auth = FirebaseAuth.instanceFor(app: app);
        await signIn.initialize(
          serverClientId:
              '186960173803-ofq1v4ud2teoij6sdd5gja47togst295.apps.googleusercontent.com',
        );

        //The error handler early
        FlutterError.onError = (details) => FlutterError.presentError(details);

        // Register GetX controllers, etc.
        initControllers();

        //ScreenUtil
        await ScreenUtil.ensureScreenSize();

        //Run app
        runApp(initApp());
      },
    );
  }

  static Widget initApp() => ChangeNotifierProvider(
    create: (_) => ThemeManager(),
    child: ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => const AppStart(),
    ),
  );

  static void initControllers() {
    Get.put(FixtureController());
    Get.put(MatchesController());
    Get.put(AuthController());
    Get.put(LeagueControllerX());
  }
}
