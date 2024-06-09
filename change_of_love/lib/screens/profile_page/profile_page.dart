import 'package:change_of_love/constants/colors.dart';
import 'package:change_of_love/data/firebase_services/firebase_storage_service.dart';
import 'package:change_of_love/data/firebase_services/firestor.dart';
import 'package:change_of_love/data/model/user_model.dart';
import 'package:change_of_love/screens/profile_page/settings.dart';
import 'package:change_of_love/widgets/custom_icon_button.dart';
import 'package:change_of_love/widgets/custom_list_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  final _storageService =
      FirebaseStorageService(); // FirebaseStorageService eklemeyi unutma
  String? _userProfileImageUrl;
  String? _username;
  String? _bio;
  int? _followerCount;
  int? _followingCount;
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
        _bio = user.bio;
        _followerCount = user.followers.length;
        _followingCount = user.following.length;
        _userProfileImageUrl = imageUrl;
        _isLoading = false; // Yükleme işlemi tamamlandı
      });
    } catch (e) {
      print("Kullanıcı bilgileri yüklenirken hata oluştu: $e");
      setState(() {
        _isLoading =
            false; // Hata durumunda da yükleme işlemi tamamlandı olarak ayarlıyoruz
      });
    }
  }

  /* @override
  void initState() {
    super.initState();
    _loadUserProfileImage();
  }

  Future<void> _loadUserProfileImage() async {
    String? userId = _auth.currentUser?.uid;
    if (userId != null) {
      String? imageUrl = await _storageService.getUserProfileImageUrl(userId);
      setState(() {
        _userProfileImageUrl = imageUrl;
      });
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 204, 239, 202),
        actions: [
          CustomIconButton(
              iconsData: Icons.settings,
              iconSize: 35,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
                );
              },
              iconColor: AppColors.textColorWhite)
        ],
      ),
      body: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 204, 239, 202),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                        ),
                        height: 300,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: _userProfileImageUrl != null
                                      ? NetworkImage(_userProfileImageUrl!)
                                      : const AssetImage(
                                              "assets/images/user.png")
                                          as ImageProvider,
                                  backgroundColor: Colors.transparent,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                _isLoading
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        _username ??
                                            "Kullanıcı adı yüklenemedi",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      _followerCount?.toString() ?? "0",
                                    ),
                                    Text(
                                      "Takipçi",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      _followingCount?.toString() ?? "0",
                                    ),
                                    Text(
                                      "Takip Edilen",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                      //Liste isimlerinin butonları
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ListsButton(
                              btnHeight: 40,
                              btnWidth: 120,
                              onTap: () {},
                              btnText: "Gönderiler",
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ListsButton(
                              btnHeight: 40,
                              btnWidth: 120,
                              onTap: () {},
                              btnText: "Teklifler",
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ListsButton(
                              btnHeight: 40,
                              btnWidth: 120,
                              onTap: () {},
                              btnText: "Kütüphane",
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ListsButton(
                              btnHeight: 40,
                              btnWidth: 120,
                              onTap: () {},
                              btnText: "Okumak İstenenler",
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ListsButton(
                              btnHeight: 40,
                              btnWidth: 120,
                              onTap: () {},
                              btnText: "Takas Edilenler",
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ListsButton(
                              btnHeight: 40,
                              btnWidth: 120,
                              onTap: () {},
                              btnText: "Takas Edilecekler",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 240,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 175, 214, 239),
                            borderRadius: BorderRadius.circular(20)),
                        height: 250,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Expanded(
                                child: Scrollbar(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Hakkında",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        _isLoading
                                            ? const CircularProgressIndicator()
                                            : Text(
                                                _bio ??
                                                    "", // Eğer biyografi yüklenmediyse boş bir metin göster
                                                overflow: TextOverflow.visible,
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              // const Spacer(),
                              /* Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton.icon(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                      icon: const Icon(Icons.person_add_alt),
                                      label: const Text("Takip Et"))
                                ],
                              ),*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 // BoxFit parametresi ile resmi sığdırma işlemini gerçekleştiriyoruz
  // BoxFit.cover, resmi tamamen kaplayacak şekilde sığdırır
  // BoxFit.fill, resmi tamamen dolduracak şekilde sığdırır
  // BoxFit.contain, resmi tamamen sığdırmaya çalışırken, orijinal oranlarını korur
  // BoxFit.fitWidth, resmi yatay yönde tamamen sığdırmaya çalışırken, orijinal oranlarını korur
  // BoxFit.fitHeight, resmi dikey yönde tamamen sığdırmaya çalışırken, orijinal oranlarını korur
  // BoxFit.scaleDown, resmi tamamen sığdırmaya çalışırken, orijinal boyutlarından büyükse küçültür