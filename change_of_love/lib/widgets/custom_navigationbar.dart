import 'package:change_of_love/add/add_page.dart';
import 'package:change_of_love/screens/home_page/home_page.dart';
import 'package:change_of_love/screens/message_page/message_page.dart';
import 'package:change_of_love/screens/profile_page/profile_page.dart';
import 'package:change_of_love/screens/search/search_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;
  final screens = [
    const HomePage(),
    const SearchPage(),
    const AddPage(),
    const MessagePage(),
    ProfilePage()
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
    return CurvedNavigationBar(
        key: navigationKey,
        color: const Color.fromARGB(255, 15, 84, 17),
        buttonBackgroundColor: Colors.amber,
        backgroundColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            this.index = index;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => screens[index],
              ),
            );
            Navigator.of(context).popUntil((route) => route.isCurrent);
          });
        },
        //animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        index: index,
        items: items);
  }
}
