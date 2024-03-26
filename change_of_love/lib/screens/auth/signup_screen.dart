import 'package:animate_do/animate_do.dart';
import 'package:change_of_love/constants/colors.dart';
import 'package:change_of_love/screens/auth/login_screen.dart';
import 'package:change_of_love/widgets/custom_elevated_button.dart';
import 'package:change_of_love/widgets/custom_text_button.dart';
import 'package:change_of_love/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late String email, password, passwordAgain;
  final formKey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
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
          child: Form(
            key: formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: Container(
                        height: 350,
                        width: double.infinity,
                        //height: MediaQuery.of(context).size.height / 3.5,
                        decoration: const BoxDecoration(
                          // color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage("assets/images/signup.png"),
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
                      child: CustomTextField(
                          fieldValidator: (value) {
                            if (value!.isEmpty) {
                              return "Bilgileri eksiksiz doldurunuz.";
                            } else {}
                            return null;
                          },
                          fieldOnSaved: (value) {
                            email = value!;
                          },
                          lblText: "Email",
                          obscureTxt: false),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: CustomTextField(
                          fieldValidator: (value) {
                            if (value!.isEmpty) {
                              return "Bilgileri eksiksiz doldurunuz.";
                            } else {}
                            return null;
                          },
                          fieldOnSaved: (value) {
                            password = value!;
                          },
                          lblText: "Şifre",
                          obscureTxt: true),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1400),
                      child: CustomTextField(
                          fieldValidator: (value) {
                            if (value!.isEmpty) {
                              return "Bilgileri eksiksiz doldurunuz.";
                            } else {}
                            return null;
                          },
                          fieldOnSaved: (value) {
                            passwordAgain = value!;
                          },
                          lblText: "Şifre tekrar",
                          obscureTxt: true),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 1500),
                  child: CustomElevatedButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          try {
                            //herhnagi bir hata dönecek mi bakalım
                            //bir user oluşturuyoruz
                            var userResult = await firebaseAuth
                                .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            formKey.currentState!
                                .reset(); //kayıt işlemi sonrası email vs girilen verileri ekrandan temizliyor.
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Kayıt olundu, giriş sayfasına yönlendiriliyorsunuz."),
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                            /* print(userResult.user!
                                .uid); */
                            //oluşsan kullanıcının uid sini görelim
                          } catch (e) {
                            print(e.toString());
                          }
                        }
                      },
                      btnText: "Hesap Oluştur"),
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
      ),
    );
  }
}
