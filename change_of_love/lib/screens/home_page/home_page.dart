import 'package:change_of_love/constants/colors.dart';
import 'package:change_of_love/screens/add_page.dart';
import 'package:change_of_love/screens/home_page/drawer_card.dart';
import 'package:change_of_love/screens/home_page/home_body_page.dart';
import 'package:change_of_love/screens/home_page/notifications_page.dart';
import 'package:change_of_love/screens/home_page/profile_card.dart';
import 'package:change_of_love/screens/message_page.dart';
import 'package:change_of_love/screens/profile_page/profile_page.dart';
import 'package:change_of_love/screens/search_page.dart';
import 'package:change_of_love/widgets/custom_icon_button.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;
  final screens = [
    const HomeBodyPage(),
    const SearchPage(),
    const AddPage(),
    const MessagePage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    final items = [
      const Icon(
        Icons.home,
        size: 30,
      ),
      const Icon(
        Icons.search,
        size: 30,
      ),
      const Icon(
        Icons.add,
        size: 30,
      ),
      const Icon(
        Icons.message,
        size: 30,
      ),
      const Icon(
        Icons.person,
        size: 30,
      ),
    ];
    return SafeArea(
      child: Scaffold(
        // extendBody: true,
        backgroundColor: AppColors.backgroundColor,
        bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
            child: CurvedNavigationBar(
                key: navigationKey,
                color: const Color.fromARGB(255, 15, 84, 17),
                buttonBackgroundColor: Colors.amber,
                backgroundColor: Colors.transparent,
                onTap: (index) {
                  setState(() {
                    this.index = index;
                  });
                },
                //animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 300),
                index: index,
                items: items)),
        appBar: AppBar(
          toolbarHeight: 80,
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
              iconsData: Icons.notifications,
              iconColor: Colors.black,
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
              iconColor: Colors.black,
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
        body: screens[index],
      ),
    );
  }
}
