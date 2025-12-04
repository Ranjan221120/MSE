import 'package:flutter/material.dart';
import 'package:get_x/get.dart';

import '../../../core/storage_data.dart';
import '../../routes/app_routes.dart';

class LoginController extends GetxController {
  final op = 0.0.obs, scale = 0.4.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLogin();
  }

  void login() async {
    isLoading.value = true;
    try {
      await StorageData.saveData('authToken', '#123456token7890');
      debugPrint("${await StorageData.getData('authToken')}");
      await Future.delayed(const Duration(milliseconds: 500));
      isLoading.value = false;
      Get.offNamed(AppRoutes.pullRequestScreen);
    } catch (e) {
      isLoading.value = false;
      debugPrint("Login error: $e");
    }
  }
  
  void isLogin() async {
    String? token = await StorageData.getData('authToken');
    if (token != null) {
      Get.offNamed(AppRoutes.pullRequestScreen);
      return;
    }
    Future.delayed(const Duration(milliseconds: 300), () {
      op.value = 1.0;
      scale.value = 1.0;
    });
  }

}