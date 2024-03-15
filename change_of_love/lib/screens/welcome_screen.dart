import 'package:animate_do/animate_do.dart';
import 'package:change_of_love/constants/colors.dart';
import 'package:change_of_love/screens/login_screen.dart';
import 'package:change_of_love/screens/signup_screen.dart';
import 'package:change_of_love/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "HOŞ GELDİN!",
                        style: TextStyle(
                            color: AppColors.textColorBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      child: const Text(
                        "Kitap tutkunları buluşma noktasındasın.\n Haydi içeri gel!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.textColorBlack, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 1400),
                  child: Container(
                    height: 150,
                    width: 150,
                    // height: MediaQuery.of(context).size.height / 3.5,
                    decoration: const BoxDecoration(color: Colors.white
                        /*image: DecorationImage(
                            image: AssetImage("assets/images/welcome.png"),
                            ),*/
                        ),
                    child: const Center(
                      child: Text(
                        "GÖRSEL",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    FadeInUp(
                      duration: const Duration(milliseconds: 1500),
                      child: CustomElevatedButton(
                          btnWidth: 400,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          btnText: "Giriş Yap"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1600),
                      child: CustomElevatedButton(
                          btnWidth: 400,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupScreen()),
                            );
                          },
                          btnText: "Hesap Oluştur"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
