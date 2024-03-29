import 'package:change_of_love/screens/home_page/drawer_card.dart';
import 'package:change_of_love/screens/home_page/notifications_page.dart';
import 'package:change_of_love/screens/home_page/post_card.dart';
import 'package:change_of_love/screens/home_page/profile_card.dart';
import 'package:change_of_love/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class HomeBodyPage extends StatefulWidget {
  const HomeBodyPage({super.key});

  @override
  State<HomeBodyPage> createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends State<HomeBodyPage> {
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
      body: Center(
          child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return const PostCard();
        },
      )),
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
