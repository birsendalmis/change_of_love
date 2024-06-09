import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> uploadImageToStorage(String name, File file) async {
    try {
      Reference ref = _storage.ref().child(name).child(_auth.currentUser!.uid);
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Yükleme işlemi sırasında bir hata oluştu: $e");
      return null;
    }
  }
}

//StorageMethod sınıfını profil fotoğrafı yüklemek için kullanıyoruz.
