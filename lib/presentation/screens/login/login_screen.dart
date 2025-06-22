import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final LoginController controller = Get.put(LoginController());

  final _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}??$');
  final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}$');

  @override
  Widget build(BuildContext context) {
    final RxBool obscureText = true.obs;
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email required';
                  }
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Obx(() => TextFormField(
                controller: controller.passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureText.value ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      obscureText.value = !obscureText.value;
                    },
                  ),
                ),
                obscureText: obscureText.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password required';
                  }
                  if (!passwordRegex.hasMatch(value)) {
                    return 'Min 6 chars, 1 number, 1 uppercase';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    FocusScope.of(context).unfocus();
                    controller.login();
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 24),
              Column(
          children: [
            Text('For Login use this types of email and password'),
            Divider(height: 10),
             const SizedBox(height: 24),
            Text('Email: abc@gmail.com'),
            SizedBox(height: 10),
            Text('Password:Abcdef123'),
           
          ],
        )
            ],
            
          ),
        ),
        
      ),
    );
  }
} 