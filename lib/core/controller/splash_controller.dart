import 'dart:async';

import 'package:employee_manager_app/views/pages/home/home_screen_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    waitTime();
  }

  void waitTime() async {
    Timer(const Duration(seconds: 4), () => Get.off(HomeScreenView()));
  }
}
