import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_up/widgets/signUpScreen.dart';

class Utility {
  static void logoutFunction(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
      (route) => false,
    );
  }

  static void loadUserPreferences(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    Function NavigatorToHomeScreen,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString('email') ?? '';
    passwordController.text = prefs.getString('password') ?? '';
    confirmPasswordController.text = prefs.getString('password') ?? '';
    NavigatorToHomeScreen();
  }
}
