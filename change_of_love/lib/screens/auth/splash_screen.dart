import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:change_of_love/constants/colors.dart';
import 'package:change_of_love/screens/auth/welcome_screen.dart';
import 'package:change_of_love/screens/home_page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Simulate some delay for splash screen
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Kullanıcı oturum açmış
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()), // Ana ekranınızı buraya ekleyin
      );
    } else {
      // Kullanıcı oturum açmamış
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LottieBuilder.asset(
                "assets/animations/Animation - 1710175389859.json")
          ],
        ),
        animationDuration: const Duration(seconds: 1),
        backgroundColor: AppColors.backgroundColor,
        splashIconSize: 800,
        nextScreen: const WelcomeScreen());
  }
}
