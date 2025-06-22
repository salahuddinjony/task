import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../home/screen/home_screen.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var emailError = ''.obs;
  var passwordError = ''.obs;
  var isLoading = false.obs;

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}');
  final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}?$');

  bool validate() {
    emailError.value = '';
    passwordError.value = '';
    bool isValid = true;
    // Add your validation logic here if needed
    return isValid;
  }

  Future<void> login() async {
    if (validate()) {
      EasyLoading.show(status: 'Logging in...');
      await Future.delayed(const Duration(seconds: 1));
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Login Successful!');
      await Future.delayed(const Duration(seconds: 1));
      Get.offAll(() => const HomeScreen());
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
} 