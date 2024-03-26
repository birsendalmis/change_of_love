import 'package:change_of_love/add/change_list_add.dart';
import 'package:change_of_love/add/library_add.dart';
import 'package:change_of_love/add/read_list_add.dart';
import 'package:change_of_love/constants/colors.dart';
import 'package:change_of_love/message_page/message_page.dart';
import 'package:change_of_love/screens/home_page/home_body_page.dart';
import 'package:change_of_love/screens/profile_page/profile_page.dart';
import 'package:change_of_love/screens/search_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int myCurrentIndex = 0;
  List pages = [
    HomeBodyPage(),
    SearchPage(),
    SizedBox(),
    MessagePage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // extendBody: true,
        backgroundColor: AppColors.backgroundColor,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.amber,
          iconSize: 35,
          unselectedItemColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 191, 222, 192),
          type: BottomNavigationBarType.fixed,
          currentIndex: myCurrentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
                label: ""),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: '',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.message,
                  size: 30,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 30,
                ),
                label: ""),
          ],
          onTap: (myNewCurrent) {
            setState(() {
              if (myNewCurrent == 2) {
                _showBottomSheet();
              } else {
                myCurrentIndex = myNewCurrent;
              }
            });
          },
        ),

        body: pages[myCurrentIndex],
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 270,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "EKLE / DÜZENLE",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Divider(
                endIndent: 90,
                indent: 90,
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              EkleRow(
                text: "Kütüphanye",
                onTapp: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LibraryAdd()),
                  );
                },
              ),
              EkleRow(
                text: "Takas Listesine",
                onTapp: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangeListAdd()),
                  );
                },
              ),
              EkleRow(
                text: "Okuma Listesine",
                onTapp: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReadListAdd()),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}

class EkleRow extends StatelessWidget {
  final VoidCallback onTapp;
  final String text;
  const EkleRow({
    super.key,
    required this.text,
    required this.onTapp,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapp,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 25),
        child: Row(
          children: [
            Icon(Icons.arrow_forward_ios),
            SizedBox(
              width: 5,
            ),
            Text(
              "$text Ekle / Düzenle",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
