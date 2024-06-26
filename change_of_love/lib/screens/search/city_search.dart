import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:change_of_love/data/firebase_services/firestor.dart';
import 'package:change_of_love/screens/profile_page/selected_profile_page.dart';
import 'package:change_of_love/screens/search/post_detail.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kullanıcı ve Paylaşımlar Arama Sayfası'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Kullanıcı adı veya şehir arayın...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: _searchQuery.isEmpty
                ? Text(" ")
                : StreamBuilder<List<Map<String, dynamic>>>(
                    stream: Stream.fromFuture(
                        FirebaseFirestor().searchUsers(_searchQuery)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                            child: Text('Arama hatası: ${snapshot.error}'));
                      }

                      List<Map<String, dynamic>> users = snapshot.data ?? [];

                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> userData = users[index];
                          return ListTile(
                            title: Text(userData['username']),
                            subtitle: Text(userData['city'] ?? 'Bilgi yok'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectedProfilePage(
                                    userId: userData['id'],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
          Expanded(
            flex: 3,
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: FirebaseFirestor().getAllPostsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Paylaşımları getirme hatası: ${snapshot.error}'));
                }

                List<Map<String, dynamic>> posts = snapshot.data ?? [];

                // Arama sorgusuna göre paylaşımları filtrele
                List<Map<String, dynamic>> filteredPosts = posts.where((post) {
                  return post['caption']
                          .toString()
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase()) ||
                      post['city']
                          .toString()
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase());
                }).toList();

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: filteredPosts.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> postData = filteredPosts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhotoDetailPage(
                              postId: postData['postId'],
                              userName: postData['username'],
                              userAssetName: postData['profileImage'],
                              postAssetName: postData['postImage'],
                              postText: postData['caption'],
                              city: postData['city'],
                              district: postData['district'],
                            ),
                          ),
                        );
                      },
                      child: CustomUserPost(
                        postId: postData['postId'],
                        userName: postData['username'],
                        userAssetName: postData['profileImage'],
                        postAssetName: postData['postImage'],
                        postText: postData['caption'],
                        city: postData['city'],
                        district: postData['district'],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomUserPost extends StatelessWidget {
  final String postId;
  final String userName;
  final String userAssetName;
  final String postAssetName;
  final String postText;
  final String? city;
  final String? district;

  CustomUserPost({
    required this.postId,
    required this.userName,
    required this.userAssetName,
    required this.postAssetName,
    required this.postText,
    this.city,
    this.district,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            postAssetName,
            fit: BoxFit.cover,
            height: 150,
          ),
          Expanded(
            child: Text(
              '$userName: $postText',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
