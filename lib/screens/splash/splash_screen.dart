import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:money_manager/screens/Register/register_page.dart';
// import 'package:money_manager/screens/home/screen_home.dart';
import 'package:money_manager/screens/log_in/log_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHomescreen();
  }

  _navigateToHomescreen() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LogInScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/money blue.png',
          height: 200,
        ),
      ),
    );
  }
}
