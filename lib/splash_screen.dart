import 'package:flutter/material.dart';
import 'package:password_manager/utills/local_storage.dart';
import 'package:password_manager/utills/secure_storage.dart';
import 'home_page/home_page.dart';
import 'login_screen/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToLogin();
    fetchFromStorage();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Text(
          "P",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 100,
          ),
        ),
      ),
    );
  }

  void navigateToLogin() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  void fetchFromStorage() async {
    emailOrNumber = await SecureStorage.fetch("emailOrNumberController");
    password = await SecureStorage.fetch("passwordController");
    biometric = await LocalStorage().fetch("biometrics") ?? false;
  }
}
