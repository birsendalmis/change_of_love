import 'dart:io';

import 'package:change_of_love/data/firebase_services/firestor.dart';
import 'package:change_of_love/data/firebase_services/storage_method.dart';
import 'package:change_of_love/util/exeption.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(
            email: email.trim(), password: password.trim());
      } else {
        throw exceptions("Tüm alanları doldurunuz");
      }
    } on FirebaseException catch (e) {
      throw exceptions(e.message.toString());
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String passwordAgain,
    required String username,
    required String bio,
    required String city,
    required String district,
    required File profile,
  }) async {
    String? URL;
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          city.isNotEmpty &&
          district.isNotEmpty) {
        if (password == passwordAgain) {
          await auth.createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
          // Profil resmini depola
          if (profile != File('')) {
            URL =
                await StorageMethod().uploadImageToStorage('Profile', profile);
          } else {
            URL = '';
          }

          // Firestore'a kullanıcı bilgilerini ekle

          await FirebaseFirestor().createUser(
            email: email,
            username: username,
            bio: bio,
            city: city,
            district: district,
            profile: URL == ''
                ? 'https://firebasestorage.googleapis.com/v0/b/instagram-8a227.appspot.com/o/person.png?alt=media&token=c6fcbe9d-f502-4aa1-8b4b-ec37339e78ab'
                : URL!,
          );
        } else {
          throw exceptions("Şifre ve şifre tekrar aynı olmalıdır");
        }
      } else {
        throw exceptions("Tüm alanları doldurunuz");
      }
    } on FirebaseException catch (e) {
      throw exceptions(
        e.message.toString(),
      );
    }
  }
}
