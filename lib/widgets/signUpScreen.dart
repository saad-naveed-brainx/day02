import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sign_up/core/constants/view_constants.dart';
import 'package:sign_up/core/constants/app_constants.dart';
import 'package:sign_up/config/theme/dark.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_up/widgets/homeScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    loadUserPreferences();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your confirm password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void loadUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString('email') ?? '';
    passwordController.text = prefs.getString('password') ?? '';
    confirmPasswordController.text = prefs.getString('password') ?? '';
    if (emailController.text != '' && passwordController.text != '') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    }
  }

  Future<void> saveUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);
    print(
      'User preferences saved ${emailController.text} ${passwordController.text}',
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print(
        'Form with valid credentials submitted ${emailController.text} ${passwordController.text} ${confirmPasswordController.text}',
      );
      saveUserPreferences();
    } else {
      print('Form with invalid credentials');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFF1E1E1E), body: _body());
  }

  Widget _body() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppConstants.gap24Px * 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ViewConstants.signUpWelcome,
                              style: TextStyle(
                                fontSize: AppConstants.font24Px,
                                color: DarkTheme.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: AppConstants.gap8Px),
                            Text(
                              ViewConstants.signUpMesage,
                              style: TextStyle(
                                fontSize: AppConstants.font16Px,
                                color: DarkTheme.textColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppConstants.gap16Px * 2),
                        TextFormField(
                          controller: emailController,
                          validator: _validateEmail,
                          style: TextStyle(color: DarkTheme.textColor),
                          onTapOutside: (value) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 20,
                            ),
                            hintText: ViewConstants.signUpEmail,
                            hintStyle: TextStyle(
                              color: DarkTheme.textGreyColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstants.gap8Px,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: DarkTheme.textColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppConstants.gap8Px,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppConstants.gap12Px),
                        TextFormField(
                          obscureText: isPasswordVisible,
                          controller: passwordController,
                          validator: _validatePassword,
                          onTapOutside: (value) {
                            FocusScope.of(context).unfocus();
                          },
                          style: TextStyle(color: DarkTheme.textColor),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 20,
                            ),
                            hintText: ViewConstants.signUpPassword,
                            hintStyle: TextStyle(
                              color: DarkTheme.textGreyColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstants.gap8Px,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: DarkTheme.textColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppConstants.gap8Px,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppConstants.gap12Px),
                        TextFormField(
                          controller: confirmPasswordController,
                          validator: _validateConfirmPassword,
                          style: TextStyle(color: DarkTheme.textColor),
                          obscureText: isConfirmPasswordVisible,
                          onTapOutside: (value) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 20,
                            ),
                            hintText: ViewConstants.signUpConfirmPassword,
                            hintStyle: TextStyle(
                              color: DarkTheme.textGreyColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordVisible =
                                      !isConfirmPasswordVisible;
                                });
                              },
                              icon: Icon(
                                isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstants.gap8Px,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: DarkTheme.textColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppConstants.gap8Px,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppConstants.gap16Px * 2),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DarkTheme.signUpButtonColor,
                              foregroundColor: DarkTheme.textColor,
                              padding: EdgeInsets.symmetric(
                                vertical: AppConstants.font18Px,
                                horizontal: AppConstants.gap24Px,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.font8Px,
                                ),
                              ),
                            ),
                            child: const Text(
                              ViewConstants.signUpButton,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppConstants.font16Px,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: DarkTheme.textGreyColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          ViewConstants.signUpOr,
                          style: TextStyle(
                            fontSize: AppConstants.font16Px,
                            color: DarkTheme.textGreyColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: DarkTheme.textGreyColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: DarkTheme.signUpButtonColor2,
                            foregroundColor: DarkTheme.textColor,
                            padding: EdgeInsets.symmetric(
                              vertical: AppConstants.font18Px,
                              horizontal: AppConstants.gap24Px,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstants.font8Px,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/ic_round-apple.svg',
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(width: AppConstants.gap8Px),
                              const Text(
                                ViewConstants.signupApple,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppConstants.font16Px,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: AppConstants.gap8Px * 2),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: DarkTheme.signUpButtonColor2,
                            foregroundColor: DarkTheme.textColor,
                            padding: EdgeInsets.symmetric(
                              vertical: AppConstants.font18Px,
                              horizontal: AppConstants.gap24Px,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstants.font8Px,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/Google.svg',
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: AppConstants.gap10Px),
                              const Text(
                                ViewConstants.signupGoogle,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppConstants.font16Px,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: AppConstants.gap8Px * 2),
                      Text(
                        ViewConstants.signUpAlreadyHaveAccount,
                        style: TextStyle(
                          fontSize: AppConstants.font16Px,
                          color: DarkTheme.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
