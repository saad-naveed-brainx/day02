import 'package:flutter/material.dart';
import 'package:sign_up/core/constants/view_constants.dart';
import 'package:sign_up/core/constants/app_constants.dart';
import 'package:sign_up/config/theme/dark.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_up/widgets/homeScreen.dart';
import 'package:sign_up/viewmodels/validators.dart';
import 'package:sign_up/viewmodels/utility.dart';
import 'package:sign_up/widgets/reusableFormField.dart';
import 'package:sign_up/assets/appAssests/class.dart';

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
    Utility.loadUserPreferences(
      context,
      emailController,
      passwordController,
      confirmPasswordController,
      NavigatorToHomeScreen,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> saveUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);
    debugPrint(
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
      debugPrint(
        'Form with valid credentials submitted ${emailController.text} ${passwordController.text} ${confirmPasswordController.text}',
      );
      saveUserPreferences();
    } else {
      debugPrint('Form with invalid credentials');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFF1E1E1E), body: _body());
  }

  Widget _body() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.gap20Px),
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
                    padding: const EdgeInsets.only(top: AppConstants.gap20Px),
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
                        CustomTextFormField(
                          controller: emailController,
                          hintText: ViewConstants.signUpEmail,
                          validator: Validators.validateEmail,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppConstants.gap14Px * 2,
                            vertical: AppConstants.gap14Px * 2,
                          ),
                        ),
                        SizedBox(height: AppConstants.gap12Px),
                        CustomTextFormField(
                          controller: passwordController,
                          hintText: ViewConstants.signUpPassword,
                          validator: Validators.validatePassword,
                          obscureText: !isPasswordVisible,
                          hasToggleVisibility: true,
                          isTextVisible: isPasswordVisible,
                          onToggleVisibility: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppConstants.gap14Px * 2,
                            vertical: AppConstants.gap20Px,
                          ),
                        ),
                        SizedBox(height: AppConstants.gap12Px),
                        CustomTextFormField(
                          controller: confirmPasswordController,
                          hintText: ViewConstants.signUpConfirmPassword,
                          validator:
                              (value) => Validators.validateConfirmPassword(
                                value,
                                passwordController,
                              ),
                          obscureText: !isConfirmPasswordVisible,
                          hasToggleVisibility: true,
                          isTextVisible: isConfirmPasswordVisible,
                          onToggleVisibility: () {
                            setState(() {
                              isConfirmPasswordVisible =
                                  !isConfirmPasswordVisible;
                            });
                          },
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppConstants.gap14Px * 2,
                            vertical: AppConstants.gap20Px,
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.gap16Px,
                        ),
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
                                AppAssets.appleIcon,
                                width: AppConstants.font14Px * 2,
                                height: AppConstants.font14Px * 2,
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
                                AppAssets.googleIcon,
                                width: AppConstants.font20Px,
                                height: AppConstants.font20Px,
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

  void NavigatorToHomeScreen() {
    if (emailController.text != '' && passwordController.text != '') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    }
  }
}
