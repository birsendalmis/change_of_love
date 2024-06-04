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
  List users = ["Alper Doruk", "Merve Nur Demir", "Fatma ÇAKIR"];
  List userAssetName = [
    "assets/images/alper.jpg",
    "assets/images/mero.jpg",
    "assets/images/fato.jpg"
  ];
  List postAssetName = [
    "assets/images/dune.jpeg",
    "assets/images/book2.jpeg",
    "assets/images/book1.jpeg"
  ];
  List postText = [
    ": Takasa açığım. Kitabı daha önce filmini izlemiştim ve çok beğenmiştim. Ancak kitap bambaşka güzellikte. Bu tür de kitap okumayı sevenlere mutlaka tavsiye ediyorum.",
    ": Takasa açığım. Bu tür de kitap okumayı sevenlere mutlaka tavsiye ediyorum.",
    ": Takas listeme eklemeler yaptım. Bakmanızı tavsiye ederim :)"
  ];
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return CustomUserPost(
                      userName: users[index],
                      postAssetName: postAssetName[index],
                      postText: postText[index],
                      userAssetName: userAssetName[index]);
                },
              ),
            )
          ],
        )
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
