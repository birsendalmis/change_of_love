import 'package:change_of_love/add/change_list_add.dart';
import 'package:change_of_love/add/library_add.dart';
import 'package:change_of_love/add/read_list_add.dart';
import 'package:change_of_love/constants/colors.dart';
import 'package:change_of_love/screens/message_page/chat_screen.dart';
import 'package:change_of_love/screens/message_page/message_page.dart';
import 'package:change_of_love/screens/home_page/home_body_page.dart';
import 'package:change_of_love/screens/post/gallery_picker_page.dart';
import 'package:change_of_love/screens/profile_page/profile_page.dart';
import 'package:change_of_love/screens/search/city_search.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int myCurrentIndex = 0;
  List pages = [
    const HomeBodyPage(),
    SearchPage(),
    const SizedBox(),
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
          height: 273,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "EKLE / DÜZENLE",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const Divider(
                endIndent: 90,
                indent: 90,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              EkleRow(
                  text: "Gönderi",
                  onTapp: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GalleryPickerPage()),
                    );
                  }),
              EkleRow(
                text: "Kütüphaneye",
                onTapp: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LibraryAdd()),
                  );
                },
              ),
              EkleRow(
                text: "Takas Listesine",
                onTapp: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangeListAdd()),
                  );
                },
              ),
              EkleRow(
                text: "Okuma Listesine",
                onTapp: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReadListAdd()),
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
            const Icon(Icons.arrow_forward_ios),
            const SizedBox(
              width: 5,
            ),
            Text(
              "$text Ekle / Düzenle",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
