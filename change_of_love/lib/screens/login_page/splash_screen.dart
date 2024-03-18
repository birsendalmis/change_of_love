import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:change_of_love/constants/colors.dart';
import 'package:change_of_love/screens/login_page/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
