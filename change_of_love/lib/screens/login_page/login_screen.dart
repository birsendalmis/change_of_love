import 'package:animate_do/animate_do.dart';
import 'package:change_of_love/constants/colors.dart';
import 'package:change_of_love/screens/home_page/home_page.dart';
import 'package:change_of_love/screens/login_page/signup_screen.dart';
import 'package:change_of_love/widgets/custom_elevated_button.dart';
import 'package:change_of_love/widgets/custom_text_button.dart';
import 'package:change_of_love/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Giriş Yap",
          style: TextStyle(
              color: AppColors.textColorWhite,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 138, 173, 136),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: AppColors.textColorWhite,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: Container(
                          height: 150,
                          width: 150,
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              "GÖRSEL",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1200),
                          child: Text(
                            "Güzel bir yazı yazılacak",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeInUp(
                          duration: const Duration(milliseconds: 1200),
                          child: const CustomTextField(
                              lblText: "Email", obscureTxt: false),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1300),
                          child: const CustomTextField(
                              lblText: "Şifre", obscureTxt: true),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1400),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: CustomElevatedButton(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                );
                              },
                              btnText: "Giriş Yap"))),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Henüz bir hesabın yok mu?",
                          style: TextStyle(fontSize: 16),
                        ),
                        CustomTextButton(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupScreen()),
                              );
                            },
                            btntext: "Hesap Oluştur!",
                            btnTxtColor: AppColors.btnColorGreen)
                      ],
                    ),
                  )
                ],
              ),
            ),
            FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.cover)),
                ))
          ],
        ),
      ),
    );
  }
}
