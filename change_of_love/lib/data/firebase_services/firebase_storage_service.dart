import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> getUserProfileImageUrl(String userId) async {
    try {
      Reference ref = _storage.ref().child('Profile').child(userId);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Profil fotoğrafı alınırken bir hata oluştu: $e");
      return null;
    }
  }
}

//FirebaseStorageService sınıfı, kullanıcı profil fotoğrafını Firebase Storage'dan almak için kullanılır.