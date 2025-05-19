import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:portfoliov2/Screen/homeScreen.dart';
import 'package:portfoliov2/theme.dart';
import 'package:portfoliov2/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: [Locale("es"), Locale("en")],
    path: "assets/translations",
    useFallbackTranslations: true,
    fallbackLocale: Locale("en"),
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeControllerC());
    return Obx(() => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Portfolio - Marc Rovira Perelló',
        theme: ThemeData.from(colorScheme: MaterialTheme.lightScheme()),
        darkTheme: ThemeData.from(colorScheme: MaterialTheme.darkScheme()),
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: Homescreen()));
  }
}
