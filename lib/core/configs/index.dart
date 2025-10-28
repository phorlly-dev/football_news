import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football_news/core/configs/app_start.dart';
import 'package:football_news/core/configs/utils.dart';
import 'package:football_news/core/configs/firebase_options.dart';
import 'package:football_news/core/controllers/auth_controller.dart';
import 'package:football_news/core/controllers/matches_controller.dart';
import 'package:football_news/core/utils/theme_manager.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Configure {
  static late FirebaseApp app;
  static late FirebaseAuth auth;

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
      designSize: Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => const AppStart(),
    ),
  );

  static void initControllers() {
    Get.put(MatchesController());
    Get.put(AuthController());
  }
}
