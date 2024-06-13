import 'package:change_of_love/data/firebase_services/firebase_storage_service.dart';
import 'package:change_of_love/data/firebase_services/firestor.dart';
import 'package:change_of_love/data/model/user_model.dart';
import 'package:change_of_love/screens/profile_page/profile_page.dart';
import 'package:change_of_love/widgets/custom_elevated_button.dart';
import 'package:change_of_love/widgets/custom_text_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final _auth = FirebaseAuth.instance;
  final _storageService = FirebaseStorageService();
  String? _userProfileImageUrl;
  String? _username;
  int? _followerCount;
  int? _followingCount;
  int? _libraryCount;
  int? _readingListCount;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      Usermodel user = await FirebaseFirestor().getUser();
      String? imageUrl =
          await _storageService.getUserProfileImageUrl(_auth.currentUser!.uid);
      setState(() {
        _username = user.username;
        _followerCount = user.followers.length;
        _followingCount = user.following.length;
        _userProfileImageUrl = imageUrl;
      });

      // Load library and reading list counts
      await _loadCounts();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print("Kullanıcı bilgileri yüklenirken hata oluştu: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCounts() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final librarySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('kutuphane')
            .get();
        final readingListSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('okumak_istedikleri')
            .get();

        setState(() {
          _libraryCount = librarySnapshot.size;
          _readingListCount = readingListSnapshot.size;
        });
      }
    } catch (e) {
      print("Count bilgileri yüklenirken hata oluştu: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: _userProfileImageUrl != null
                ? NetworkImage(_userProfileImageUrl!)
                : const AssetImage("assets/images/user.png") as ImageProvider,
          ),
          SizedBox(height: 10),
          _isLoading
              ? const CircularProgressIndicator()
              : Text(
                  _username ?? "Kullanıcı adı yüklenemedi",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
        ],
      ),
      content: SizedBox(
        height: 170,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: _isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(_followingCount?.toString() ?? "0"),
                            Text(
                              "Takip",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(_libraryCount?.toString() ?? "0"),
                            Text(
                              "Kütüphanem",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(_followerCount?.toString() ?? "0"),
                            Text(
                              "Takipçi",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(_readingListCount?.toString() ?? "0"),
                            Text(
                              "Okuma Listem",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
      actions: [
        Row(
          children: [
            CustomTextButton(
              btntext: "Kapat",
              btnTxtColor: Colors.red,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            CustomElevatedButton(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
              btnText: "Hesap Detay",
              btnWidth: 10,
              btnHeight: 35,
              btnColor: const Color.fromARGB(255, 124, 176, 126),
            )
          ],
        ),
      ],
    );
  }
}
