import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_up/widgets/signUpScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Home Screen'),
            TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                  (route) => false,
                );
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
