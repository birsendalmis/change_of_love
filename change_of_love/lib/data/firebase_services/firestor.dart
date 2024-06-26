import 'package:change_of_love/data/model/user_model.dart';
import 'package:change_of_love/util/exeption.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirebaseFirestor {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> createUser({
    required String email,
    required String username,
    required String bio,
    required String city,
    required String district,
    required String profile,
  }) async {
    await firebaseFirestore.collection('users').doc(auth.currentUser!.uid).set({
      'email': email,
      'username': username,
      'bio': bio,
      'city': city,
      'district': district,
      'profile': profile,
      'followers': [],
      'following': [],
    });
    return true;
  }

  Future<Usermodel> getUser() async {
    try {
      // Kullanıcı oturumu açmışsa devam et
      if (auth.currentUser != null) {
        final user = await firebaseFirestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get();
        final snapuser = user.data()!;
        return Usermodel(
          snapuser['bio'],
          snapuser['email'],
          snapuser['followers'],
          snapuser['following'],
          snapuser['profile'],
          snapuser['username'],
          snapuser['city'],
          snapuser['district'],
        );
      } else {
        // Kullanıcı oturumu açmamışsa, uygun bir hata işleyicisiyle hata döndür
        throw Exception("Kullanıcı oturumu açmamış");
      }
    } on FirebaseException catch (e) {
      // Firebase'tan gelen hataları yakalayarak uygun şekilde işle
      throw exceptions(e.message.toString());
    }
  }

  Future<bool> createPost({
    required String postImage,
    required String caption,
    required String location,
       required String? city,
    required String? district,
    required int likeCount, // Beğeni sayısı özelliği eklendi
    required int commentCount,
    required DateTime time, // Paylaşılma zamanı özelliği eklendi
  }) async {
    var uid = const Uuid().v4();
    Usermodel user = await getUser();
    await firebaseFirestore.collection('posts').doc(uid).set({
      'postImage': postImage,
      'username': user.username,
      'profileImage': user.profile,
      'caption': caption,
      'location': location,
      'uid': auth.currentUser!.uid,
      'city':user.city,
      'district':user.district,
      'postId': uid,
      'likeCount': likeCount, // Yeni özellik: Beğeni sayısı
      'commentCount': commentCount,
      'time': time, // Yeni özellik: Paylaşılma zamanı
    });
    return true;
  }

  // Post akışı
  Stream<List<Map<String, dynamic>>> getPostsStream() {
    return firebaseFirestore.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        return {
          'postId': doc.id,
          'username': data.containsKey('username') ? data['username'] : null,
          'profileImage':
              data.containsKey('profileImage') ? data['profileImage'] : null,
          'postImage': data.containsKey('postImage') ? data['postImage'] : null,
          'caption': data.containsKey('caption') ? data['caption'] : null,
          'city': data.containsKey('city')
              ? data['city']
              : null, // Şehir bilgisini güvenli bir şekilde okuyoruz
         'district': data.containsKey('district')
              ? data['district']
              : null,
        };
      }).toList();
    });
  }

// Beğeni sayısı
  Future<int> getLikeCount(String postId) async {
    try {
      final snapshot =
          await firebaseFirestore.collection('posts').doc(postId).get();
      final data = snapshot.data();
      if (data != null && data.containsKey('likeCount')) {
        return data['likeCount'] ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      print('Error getting like count: $e');
      throw e;
    }
  }

  // Yorum sayısı
  Future<int> getCommentCount(String postId) async {
    try {
      final snapshot = await firebaseFirestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .get();
      return snapshot.size;
    } catch (e) {
      print('Error getting comment count: $e');
      throw e;
    }
  }

  /*Future<bool> creatReels({
    required String video,
    required String caption,
  }) async {
    var uid = const Uuid().v4();
    DateTime data = DateTime.now();
    Usermodel user = await getUser();
    await _firebaseFirestore.collection('reels').doc(uid).set({
      'reelsvideo': video,
      'username': user.username,
      'profileImage': user.profile,
      'caption': caption,
      'uid': _auth.currentUser!.uid,
      'postId': uid,
      'like': [],
      'time': data
    });
    return true;
  }*/

 Future<void> followUser(String targetUserId) async {
  final String currentUserId = auth.currentUser!.uid;

  // Takip edilen kullanıcının takipçi listesine eklenecek
  await firebaseFirestore.collection('users').doc(targetUserId).update({
    'followers': FieldValue.arrayUnion([currentUserId])
  });

  // Mevcut kullanıcının takip ettiği kullanıcılar listesine eklenecek
  await firebaseFirestore.collection('users').doc(currentUserId).update({
    'following': FieldValue.arrayUnion([targetUserId])
  });
}

 Future<void> unfollowUser(String targetUserId) async {
  final String currentUserId = auth.currentUser!.uid;

  // Takip edilen kullanıcının takipçi listesinden çıkarılacak
  await firebaseFirestore.collection('users').doc(targetUserId).update({
    'followers': FieldValue.arrayRemove([currentUserId])
  });

  // Mevcut kullanıcının takip ettiği kullanıcılar listesinden çıkarılacak
  await firebaseFirestore.collection('users').doc(currentUserId).update({
    'following': FieldValue.arrayRemove([targetUserId])
  });
}

Future<bool> isFollowing(String targetUserId) async {
  final String currentUserId = auth.currentUser!.uid;
  final userDoc = await firebaseFirestore.collection('users').doc(currentUserId).get();

  List following = userDoc.data()!['following'];
  return following.contains(targetUserId);
}


 
  // Yorum ekleme

  Future<bool> comments({
    required String comment,
    required String type,
    required String uidd,
  }) async {
    var uid = const Uuid().v4();
    Usermodel user = await getUser();
    await firebaseFirestore
        .collection(type)
        .doc(uidd)
        .collection('comments')
        .doc(uid)
        .set({
      'comment': comment,
      'username': user.username,
      'profileImage': user.profile,
      'CommentUid': uid,
    });
    return true;
  }

  Future<Map<String, dynamic>?> getUserById(String userId) async {
    try {
      DocumentSnapshot doc =
          await firebaseFirestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>?;
      } else {
        print('No user found with id: $userId');
        return null;
      }
    } catch (e) {
      print('Error getting user details by id: $e');
      throw e;
    }
  }

  Stream<List<Map<String, dynamic>>> getAllPostsStream() {
    return firebaseFirestore.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        return {
          'postId': doc.id,
          'username': data.containsKey('username') ? data['username'] : null,
          'profileImage':
              data.containsKey('profileImage') ? data['profileImage'] : null,
          'postImage': data.containsKey('postImage') ? data['postImage'] : null,
          'caption': data.containsKey('caption') ? data['caption'] : null,
          'city': data.containsKey('city') ? data['city'] : null,
        };
      }).toList();
    });
  }

  // Post beğenisi kontrol etme
  Future<bool> isPostLiked(String postId, String userId) async {
    try {
      final snapshot =
          await firebaseFirestore.collection('posts').doc(postId).get();
      final data = snapshot.data();
      if (data != null && data.containsKey('like')) {
        List likes = data['like'];
        return likes.contains(userId);
      } else {
        return false;
      }
    } catch (e) {
      print('Error checking like status: $e');
      return false;
    }
  }

// Beğeni güncelleme
  Future<void> updateLike({
    required String postId,
    required String userId,
    required bool isLiked,
  }) async {
    try {
      if (isLiked) {
        await firebaseFirestore.collection('posts').doc(postId).update({
          'like': FieldValue.arrayRemove([userId]),
          'likeCount': FieldValue.increment(-1),
        });
      } else {
        await firebaseFirestore.collection('posts').doc(postId).update({
          'like': FieldValue.arrayUnion([userId]),
          'likeCount': FieldValue.increment(1),
        });
      }
    } catch (e) {
      print('Error updating like: $e');
      throw e;
    }
  }

  Future<String> like({
    required List like,
    required String type,
    required String uid,
    required String postId,
  }) async {
    String res = 'some error';
    try {
      if (like.contains(uid)) {
        await firebaseFirestore.collection(type).doc(postId).update({
          'like': FieldValue.arrayRemove([uid])
        });
      } else {
        await firebaseFirestore.collection(type).doc(postId).update({
          'like': FieldValue.arrayUnion([uid])
        });
      }
      res = 'seccess';
    } on Exception catch (e) {
      res = e.toString();
    }
    return res;
  }

  // Kitap ekleme
  Future<void> addBookToList({
    required String userId,
    required String listName,
    required Map<String, dynamic> bookInfo,
  }) async {
    try {
      await firebaseFirestore
          .collection('user_lists')
          .doc(userId)
          .collection(listName)
          .add(bookInfo);
    } catch (e) {
      print('Error adding book to list: $e');
      throw e;
    }
  }

  // Kitap silme
  Future<void> removeBookFromList({
    required String userId,
    required String listName,
    required String bookId,
  }) async {
    try {
      await firebaseFirestore
          .collection('user_lists')
          .doc(userId)
          .collection(listName)
          .doc(bookId)
          .delete();
    } catch (e) {
      print('Error removing book from list: $e');
      throw e;
    }
  }

  // Kullanıcı listesi akışı
  Stream<List<Map<String, dynamic>>> getUserList({
    required String userId,
    required String listName,
  }) {
    return firebaseFirestore
        .collection('user_lists')
        .doc(userId)
        .collection(listName)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  //searchUsers fonksiyonu, kullanıcı adını sorgulamak için Firestore'da bir sorgu çalıştırır.
  Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    try {
      // Arama sorgusunu iki kritere göre yapıyoruz: kullanıcı adı ve şehir
      final results = await firebaseFirestore
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: query)
          .where('username', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      // Şehir bilgisi olan kullanıcılar için ayrı bir sorgu
      final cityResults = await firebaseFirestore
          .collection('users')
          .where('city', isEqualTo: query)
          .get();

      // İki sorgunun sonuçlarını birleştiriyoruz
      final List<Map<String, dynamic>> combinedResults = [];
      combinedResults.addAll(
          results.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList());
      combinedResults.addAll(cityResults.docs
          .map((doc) => {...doc.data(), 'id': doc.id})
          .toList());

      // Duplicate entries'leri kaldırmak için bir set kullanarak tekrarlananları siliyoruz
      final uniqueResults = combinedResults.toSet().toList();

      print('Search results: $uniqueResults');
      return uniqueResults;
    } catch (e) {
      print('Error searching users: $e');
      throw e;
    }
  }

  Future<List<Map<String, dynamic>>> searchUsersByCity(String cityQuery) async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection('users')
          .where('city', isEqualTo: cityQuery)
          .get();

      final List<Map<String, dynamic>> users = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'username': doc['username'],
          'city': doc['city'],
          'profileImage': doc['profile'] ?? null,
        };
      }).toList();

      return users;
    } catch (e) {
      print('Error searching users by city: $e');
      throw e;
    }
  }

  // Kullanıcı detayları alma
  Future<Map<String, dynamic>?> getUserDetails(String userId) async {
    try {
      DocumentSnapshot doc =
          await firebaseFirestore.collection('users').doc(userId).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      print('Error getting user details: $e');
      throw e;
    }
  }
}
