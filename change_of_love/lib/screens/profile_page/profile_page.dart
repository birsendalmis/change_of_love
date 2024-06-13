import 'package:change_of_love/constants/colors.dart';
import 'package:change_of_love/data/firebase_services/firebase_storage_service.dart';
import 'package:change_of_love/data/firebase_services/firestor.dart';
import 'package:change_of_love/data/model/user_model.dart';
import 'package:change_of_love/screens/profile_page/settings.dart';
import 'package:change_of_love/screens/search/selected_book_detail.dart';
import 'package:change_of_love/widgets/custom_icon_button.dart';
import 'package:change_of_love/widgets/custom_list_button.dart';
import 'package:change_of_love/widgets/custom_user_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  final _storageService = FirebaseStorageService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _userProfileImageUrl;
  String? _username;
  String? _bio;
  int? _followerCount;
  int? _followingCount;
  bool _isLoading = true;
  int _selectedIndex = 0;
  List<Map<String, String>> books = [];
  List<Map<String, String>> _itemsToExchange = [];
  List<Map<String, String>> _readingList =
      []; // _readingList değişkenini tanımla
  List<Map<String, dynamic>> _userPosts = [];
  String? _locationInfo; // Eklenen il-ilçe bilgisi

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _loadLibraryBooks();
    _loadReadingList();
    _loadItemsToExchange();
    _loadUserPosts();
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
        _isLoading = false;
        // Kullanıcı adı ve il-ilçe bilgisini birleştirerek gösterilecek string'i oluştur
        String location = '${user.city} - ${user.district}';
        _locationInfo = location;
      });
    } catch (e) {
      print("Kullanıcı bilgileri yüklenirken hata oluştu: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadLibraryBooks() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final QuerySnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('kutuphane')
                .get();

        setState(() {
          books = snapshot.docs
              .map((doc) => Map<String, String>.from(doc.data()))
              .toList();
        });
      }
    } catch (error) {
      print('loadBooks Error: $error');
    }
  }

  Future<void> _loadReadingList() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final QuerySnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('okumak_istedikleri')
                .get();

        setState(() {
          _readingList = snapshot.docs
              .map((doc) => Map<String, String>.from(doc.data()))
              .toList();
        });
      }
    } catch (error) {
      print('loadReadingList Error: $error');
    }
  }

  Future<void> _loadItemsToExchange() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final QuerySnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('takas_edilecekler')
                .get();

        setState(() {
          _itemsToExchange = snapshot.docs
              .map((doc) => Map<String, String>.from(doc.data()))
              .toList();
        });
      }
    } catch (error) {
      print('loadItemsToExchange Error: $error');
    }
  }

  Future<void> _loadUserPosts() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection('posts')
            .where('uid', isEqualTo: user.uid)
            .get();

        print(
            'Postlar: ${snapshot.docs.map((doc) => doc.data()).toList()}'); // Veri kontrolü için

        setState(() {
          _userPosts = snapshot.docs.map((doc) => doc.data()).toList();
        });
      }
    } catch (error) {
      print('loadUserPosts Error: $error');
    }
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return ListView.builder(
          itemCount: _userPosts.length,
          itemBuilder: (context, index) {
            final post = _userPosts[index];
            return CustomUserPost(
              postId: post['postId'],
              userName: _username ?? '',
              postAssetName: post['postImage'],
              postText: post['caption'],
              userAssetName: _userProfileImageUrl ?? '',
            );
          },
        );
      case 1:
        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            final bookImage = book['bookImage'] ?? '';
            return ListTile(
              title: Text(book['bookName'] ?? ''),
              subtitle: Text(book['authorName'] ?? ''),
              leading: bookImage.isNotEmpty
                  ? Image.network(
                      bookImage,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error);
                      },
                    )
                  : const Icon(Icons.camera_alt),
              onTap: () {
                // Tıklanan kitabın detay sayfasına gitmek için Navigator kullanarak yönlendirme yapın
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(bookInfo: book),
                  ),
                );
              },
            );
          },
        );
//ibrary content

      case 2:
        return ListView.builder(
          itemCount: _readingList.length,
          itemBuilder: (context, index) {
            final book = _readingList[index];
            final bookImage = book['bookImage'] ?? '';
            return ListTile(
              title: Text(book['bookName'] ?? ''),
              subtitle: Text(book['authorName'] ?? ''),
              leading: bookImage.isNotEmpty
                  ? Image.network(bookImage,
                      errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error);
                    })
                  : const Icon(Icons.camera_alt),
            );
          },
        ); // Reading list contentceholder for reading list

      case 3:
        return ListView.builder(
          itemCount: _itemsToExchange.length,
          itemBuilder: (context, index) {
            final item = _itemsToExchange[index];
            final itemImage = item['itemImage'] ?? '';
            return ListTile(
              title: Text(item['itemName'] ?? ''),
              subtitle: Text(item['itemDescription'] ?? ''),
              leading: itemImage.isNotEmpty
                  ? Image.network(itemImage,
                      errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error);
                    })
                  : const Icon(Icons.error),
            );
          },
        ); // Items to exchange contenteholder for items to exchange

      case 4:
        return Center(child: Text('Teklifler')); // Placeholder for offers

      case 5:
        return Center(
            child: Text('Takas Edilenler')); // Placeholder for exchanged items
      default:
        return Center(child: Text('Gönderiler')); // Default case
    }
  }

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
                              bottomLeft: Radius.circular(35),
                              bottomRight: Radius.circular(35)),
                        ),
                        height: 250,
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
                                  height: 5,
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
                                SizedBox(height: 1),
                                _isLoading
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        _locationInfo ??
                                            "Konum bilgisi yüklenemedi",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600]),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
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
                        height: 170,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ListsButton(
                              btnHeight: 40,
                              btnWidth: 120,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 0;
                                });
                              },
                              btnText: "Gönderiler",
                              btnColor: _selectedIndex == 0
                                  ? Color.fromARGB(255, 129, 174, 126)
                                  : AppColors.listButtonColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ListsButton(
                              btnHeight: 40,
                              btnWidth: 120,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 1;
                                });
                              },
                              btnText: "Kütüphane",
                              btnColor: _selectedIndex == 1
                                  ? Color.fromARGB(255, 129, 174, 126)
                                  : AppColors.listButtonColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ListsButton(
                              btnHeight: 40,
                              btnWidth: 120,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 2;
                                });
                              },
                              btnText: "Okumak İstenenler",
                              btnColor: _selectedIndex == 2
                                  ? Color.fromARGB(255, 129, 174, 126)
                                  : AppColors.listButtonColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ListsButton(
                              btnHeight: 40,
                              btnWidth: 120,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 3;
                                });
                              },
                              btnText: "Takas Edilecekler",
                              btnColor: _selectedIndex == 3
                                  ? Color.fromARGB(255, 129, 174, 126)
                                  : AppColors.listButtonColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ListsButton(
                              btnHeight: 40,
                              btnWidth: 120,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 4;
                                });
                              },
                              btnText: "Teklifler",
                              btnColor: _selectedIndex == 4
                                  ? Color.fromARGB(255, 129, 174, 126)
                                  : AppColors.listButtonColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ListsButton(
                              btnHeight: 40,
                              btnWidth: 120,
                              onTap: () {
                                setState(() {
                                  _selectedIndex = 5;
                                });
                              },
                              btnText: "Takas Edilenler",
                              btnColor: _selectedIndex == 5
                                  ? Color.fromARGB(255, 129, 174, 126)
                                  : AppColors.listButtonColor,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 215,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 175, 214, 239),
                            borderRadius: BorderRadius.circular(20)),
                        height: 200,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 470,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(20)),
                      height: 250,
                      child: _buildContent(),
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
