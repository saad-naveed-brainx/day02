import 'package:flutter/material.dart';
import 'package:sign_up/core/constants/view_constants.dart';
import 'package:sign_up/core/constants/app_constants.dart';
import 'package:sign_up/config/theme/dark.dart';
import 'package:sign_up/widgets/textField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      // Apply gradient as background for the body
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topLeft, // Gradient starts from top-left (0% 0%)
          radius: 1.0, // Full gradient spread
          colors: [
            Color(0xFF292E3A), // #292E3A (first color)
            Color(0xFF1E1E1E), // #1E1E1E (second color)
          ],
          stops: [0.0, 1.0], // Where colors start and end
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 112, left: 0),
              child: Column(
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
            ),
            SizedBox(height: AppConstants.gap16Px * 2),
            Container(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
