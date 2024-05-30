// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/utils/auth.dart';
import 'package:flutter_application_1/view/auth/splash_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'services/theme.dart';
import 'utils/lokasi.dart';
import 'view/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = await getAuthentication();

  await dapatkanLokasiPengguna();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  runApp(ProviderScope(
    child: MyApp(
      isLoggedIn: isLoggedIn,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
   MyApp({super.key, required this.isLoggedIn});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
   return Obx(() {
     themeController.updateSystemUIOverlayStyle();
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.theme,
        home: SplashPage(isLoggedIn: isLoggedIn,),
      );
    });
  }
  }

