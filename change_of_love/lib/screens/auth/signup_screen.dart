import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:change_of_love/constants/colors.dart';
import 'package:change_of_love/data/firebase_services/firebase_auth.dart';
import 'package:change_of_love/screens/auth/login_page.dart';
import 'package:change_of_love/util/dialog.dart';
import 'package:change_of_love/util/exeption.dart';
import 'package:change_of_love/util/image_picker.dart';
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
  late String email, password, passwordAgain, username, bio;
  final emailController = TextEditingController();
  FocusNode email_F = FocusNode();
  final passwordcontroller = TextEditingController();
  FocusNode password_F = FocusNode();
  final userNameController = TextEditingController();
  FocusNode userName_F = FocusNode();
  final bioController = TextEditingController();
  FocusNode bio_F = FocusNode();
  File? _imageFile;
  final passwordAgainController = TextEditingController();
  FocusNode passwordAgain_F = FocusNode();
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
      body: SafeArea(
        child: SingleChildScrollView(
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
                      const SizedBox(
                        height: 80,
                      ),
                      /*FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: Container(
                          height: 300,
                          width: double.infinity,
                          //height: MediaQuery.of(context).size.height / 3.5,
                          decoration: const BoxDecoration(
                            // color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage("assets/images/signup.png"),
                            ),
                          ),
                        ),
                      ),*/
                      FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: GestureDetector(
                          onTap: () async {
                            File _imagefilee =
                                await ImagePickerr().uploadImage('gallery');
                            setState(() {
                              _imageFile = _imagefilee;
                            });
                          },
                          child: CircleAvatar(
                            radius: 77,
                            backgroundColor: Colors.grey,
                            child: _imageFile == null
                                ? CircleAvatar(
                                    radius: 75,
                                    backgroundColor: Colors.grey.shade200,
                                    backgroundImage: const AssetImage(
                                      "assets/images/user.png",
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 75,
                                    backgroundColor: Colors.grey.shade200,
                                    backgroundImage: Image.file(
                                      _imageFile!,
                                      fit: BoxFit.cover,
                                    ).image,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      /* FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: Text(
                          "Anlamlı bir yazı yazılacak",
                          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                        ),
                      ),*/
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
                              username = value!;
                            },
                            lblText: "Kullanıcı Adı",
                            fieldController: userNameController,
                            fieldFocusNode: userName_F,
                            obscureTxt: false),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: CustomTextField(
                            fieldOnSaved: (value) {
                              bio = value!;
                            },
                            lblText: "Bio",
                            fieldController: bioController,
                            fieldFocusNode: bio_F,
                            obscureTxt: false),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                            fieldController: emailController,
                            fieldFocusNode: email_F,
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
                            fieldController: passwordcontroller,
                            fieldFocusNode: password_F,
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
                            fieldController: passwordAgainController,
                            fieldFocusNode: passwordAgain_F,
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
                          try {
                            await Authentication().signUp(
                              email: emailController.text,
                              password: passwordcontroller.text,
                              passwordAgain: passwordAgainController.text,
                              username: userNameController.text,
                              bio: bioController.text,
                              profile: _imageFile ?? File(''),
                            );
                            // Kayıt işlemi başarıyla tamamlandıktan sonra alanları temizle
                            emailController.clear();
                            passwordcontroller.clear();
                            passwordAgainController.clear();
                            userNameController.clear();
                            bioController.clear();
                            setState(() {
                              _imageFile = null;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          } on exceptions catch (e) {
                            dialogBuilder(context, e.message);
                          }
                          /* if (formKey.currentState!.validate()) {
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
                          }*/
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
      ),
    );
  }
}
