import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfoliov2/theme.dart';
import 'dart:html' as html;

class ThemeControllerC extends GetxController {
  // Inicializa el tema basado en el tema del sistema
  late RxBool isDarkMode;

  @override
  void onInit() {
    super.onInit();
    isDarkMode = RxBool(Get.isDarkMode);
  }

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(
      isDarkMode.value
          ? ThemeData.from(colorScheme: MaterialTheme.darkScheme())
          : ThemeData.from(colorScheme: MaterialTheme.lightScheme()),
    );
  }
}

void newDeployURL(String url) {
  html.window.open(url, '_blank');
}
