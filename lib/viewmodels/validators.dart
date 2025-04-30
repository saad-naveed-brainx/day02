import 'package:sign_up/core/constants/view_constants.dart';
import 'package:flutter/material.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return ViewConstants.pleaseEnterYourEmail;
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return ViewConstants.pleaseEnterValidEmail;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return ViewConstants.pleaseEnterYourPassword;
    }
    if (value.length < 8) {
      return ViewConstants.passwordMustBeAtLeast8CharactersLong;
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    TextEditingController passwordController,
  ) {
    if (value == null || value.isEmpty) {
      return ViewConstants.pleaseEnterYourConfirmPassword;
    }
    if (value != passwordController.text) {
      return ViewConstants.passwordsDoNotMatch;
    }
    return null;
  }
}
