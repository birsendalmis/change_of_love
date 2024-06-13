import 'package:change_of_love/data/firebase_services/firestor.dart';
import 'package:change_of_love/screens/home_page/drawer_card.dart';
import 'package:change_of_love/screens/home_page/notifications_page.dart';
import 'package:change_of_love/screens/home_page/profile_card.dart';
import 'package:change_of_love/widgets/custom_icon_button.dart';
import 'package:change_of_love/widgets/custom_user_post.dart';
import 'package:flutter/material.dart';

class HomeBodyPage extends StatefulWidget {
  const HomeBodyPage({super.key});

  @override
  State<HomeBodyPage> createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends State<HomeBodyPage> {
  FirebaseFirestor _firebaseFirestore = FirebaseFirestor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerCard(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 220, 250, 221),
        toolbarHeight: 75,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("C "),
            Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 145, 14, 5),
            ),
            Text(" F")
          ],
        ),
        actions: [
          CustomIconButton(
            iconSize: 33,
            iconsData: Icons.notifications_active_outlined,
            iconColor: const Color.fromARGB(255, 0, 0, 0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsPage(),
                ),
              );
            },
          ),
          CustomIconButton(
            iconsData: Icons.person_outline,
            iconColor: Colors.black,
            iconSize: 33,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const ProfileCard();
                },
              );
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _firebaseFirestore
            .getPostsStream(), // Firestore'dan gönderilerin akışını al
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Veriler yükleniyorsa
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Veriler alınamadıysa
            return Center(child: Text('Veriler alınamadı: ${snapshot.error}'));
          } else {
            // Veriler alındıysa
            final List<Map<String, dynamic>> posts =
                snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return CustomUserPost(
                  postId: post['postId'],
                  userName: post['username'],
                  postAssetName: post['postImage'],
                  postText: post['caption'],
                  userAssetName: post['profileImage'],
                );
              },
            );
          }
        },
      ),
      /*CustomScrollView(
          slivers: [
            StreamBuilder(
              stream: _firebaseFirestore
                  .collection('posts')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return PostWidget(snapshot.data!.docs[index].data());
                },
                        childCount: snapshot.data == null
                            ? 0
                            : snapshot.data!.docs.length));
              },
            )
          ],
        )*/
    );
    /*Center(
        child: ListView.builder(
      itemBuilder: (context, index) {
        return const PostCard();
      },
      itemCount: 10,
    ),
    );*/
  }
}
