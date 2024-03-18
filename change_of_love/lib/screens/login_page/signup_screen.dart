import 'package:animate_do/animate_do.dart';
import 'package:change_of_love/constants/colors.dart';
import 'package:change_of_love/screens/login_page/login_screen.dart';
import 'package:change_of_love/widgets/custom_elevated_button.dart';
import 'package:change_of_love/widgets/custom_text_button.dart';
import 'package:change_of_love/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Hesap Oluştur",
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1200),
                    child: Text(
                      "Anlamlı bir yazı yazılacak",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
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
                  const SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1400),
                    child: const CustomTextField(
                        lblText: "Şifre tekrar", obscureTxt: true),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 1500),
                child: CustomElevatedButton(
                    onTap: () {}, btnText: "Hesap Oluştur"),
              ),
              const SizedBox(
                height: 15,
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 1600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Zaren bir hesabınız var mı?",
                      style: TextStyle(fontSize: 16),
                    ),
                    CustomTextButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        btntext: "Giriş Yap!",
                        btnTxtColor: AppColors.btnColorGreen)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
