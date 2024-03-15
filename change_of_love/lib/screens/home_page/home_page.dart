import 'package:change_of_love/screens/home_page/drawer_card.dart';
import 'package:change_of_love/screens/home_page/home_body_page.dart';
import 'package:change_of_love/screens/home_page/notifications_page.dart';
import 'package:change_of_love/screens/home_page/profile_card.dart';
import 'package:change_of_love/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            CustomIconButton(
              iconsData: Icons.notifications,
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
              iconsData: Icons.person,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileCard()),
                );
              },
            )
          ],
        ),
        drawer: const DrawerCard(),
        body: const HomeBodyPage(),
      ),
    );
  }
}
