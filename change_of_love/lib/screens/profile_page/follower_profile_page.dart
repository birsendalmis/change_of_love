import 'package:change_of_love/constants/colors.dart';
import 'package:change_of_love/screens/search/city_search.dart';
import 'package:change_of_love/screens/search/selected_book_detail.dart';
import 'package:change_of_love/widgets/custom_list_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:change_of_love/screens/message_page/message_detail.dart';

class FollowerProfilePage extends StatefulWidget {
  final String userId;

  const FollowerProfilePage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _FollowerProfilePageState createState() => _FollowerProfilePageState();
}

class _FollowerProfilePageState extends State<FollowerProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool follow = false;
  Map<String, dynamic>? userData;
  List<Map<String, String>> _readingList = [];
  List<Map<String, String>> books = [];
  List<Map<String, String>> _itemsToExchange = [];
  List<Map<String, dynamic>> _userPosts = [];
  String? _userProfileImageUrl;
  String? _username;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _getUserData();
    _loadLibraryBooks();
    _loadReadingList();
    _loadItemsToExchange();
    _loadUserPosts();
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

  // Firestore'dan kullanıcı verilerini al
  void _getUserData() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();
      setState(() {
        userData = userSnapshot.data() as Map<String, dynamic>?;
      });
    } catch (e) {
      print('Kullanıcı verilerini alma hatası: $e');
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
    print(userData);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 204, 239, 202),
      ),
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : SizedBox(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 204, 239, 202),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        height: 250,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: userData != null
                                      ? NetworkImage(userData!['profile']!)
                                      : const AssetImage(
                                              'assets/images/user.png')
                                          as ImageProvider, // Varsayılan profil resmi
                                ),
                                SizedBox(height: 5),
                                Text(
                                  userData!['username'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(userData!['city'] ?? 'İl'),
                                    Text(" - "),
                                    Text(userData!['district'] ?? 'İlçe')
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(userData!['following'] == null
                                        ? "0"
                                        : "0"),
                                    Text(
                                      "Takipçi", // Buraya userData'dan takipçi sayısını alabilirsiniz
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(userData!['followers'] == null
                                        ? "0"
                                        : "0"),
                                    Text(
                                      "Takip Edilen", // Buraya userData'dan takip edilen sayısını alabilirsiniz
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
                      SizedBox(height: 170),
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
                          color: Color.fromARGB(255, 175, 214, 239),
                          borderRadius: BorderRadius.circular(20),
                        ),
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
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          userData!['bio'] ?? 'Bio bilgisi',
                                          overflow: TextOverflow.visible,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MessageDetails(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 246, 249, 252),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    icon: Icon(Icons.message,
                                        color: Colors.black),
                                    label: Text(
                                      "Mesaj",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        follow = !follow;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: follow == false
                                          ? Color.fromARGB(255, 246, 249, 252)
                                          : Color.fromARGB(255, 33, 103, 35),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.person_add_alt,
                                      color: follow == false
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    label: Text(
                                      follow == false
                                          ? "Takip et"
                                          : "Takip ediliyor",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: follow == false
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
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
    );
  }
}
