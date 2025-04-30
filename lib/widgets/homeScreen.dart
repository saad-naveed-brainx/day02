import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_up/core/constants/view_constants.dart';
import 'package:sign_up/viewmodels/utility.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ViewConstants.welcomeToTheHomeScreen),
            TextButton(
              onPressed: () => Utility.logoutFunction(context),
              child: Text(ViewConstants.logout),
            ),
          ],
        ),
      ),
    );
  }
}
