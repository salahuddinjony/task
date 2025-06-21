import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var emailError = ''.obs;
  var passwordError = ''.obs;
  var isLoading = false.obs;

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}$');

  bool validate() {
    emailError.value = '';
    passwordError.value = '';
    bool isValid = true;

    // if (!emailRegex.hasMatch(emailController.text.trim())) {
    //   emailError.value = 'Enter a valid email';
    //   isValid = false;
    // }
    // if (!passwordRegex.hasMatch(passwordController.text)) {
    //   passwordError.value = 'Min 6 chars, 1 number, 1 uppercase';
    //   isValid = false;
    // }
    return isValid;
  }

  void login() {
    if (validate()) {
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