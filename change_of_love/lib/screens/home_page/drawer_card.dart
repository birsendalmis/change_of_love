import 'package:change_of_love/screens/drawer_page/cof_about.dart';
import 'package:change_of_love/screens/drawer_page/developer_about.dart';
import 'package:change_of_love/screens/lists/library.dart';
import 'package:change_of_love/screens/lists/okumak_istedikleri.dart';
import 'package:change_of_love/screens/lists/takas_edilecekler.dart';
import 'package:change_of_love/screens/lists/takas_edilenler.dart';
import 'package:change_of_love/screens/lists/teklifler.dart';
import 'package:flutter/material.dart';

class DrawerCard extends StatefulWidget {
  const DrawerCard({super.key});

  @override
  State<DrawerCard> createState() => _DrawerCardState();
}

class _DrawerCardState extends State<DrawerCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(80.0), // Sağ üst köşeyi yuvarlat
        bottomRight: Radius.circular(80.0), // Sağ alt köşeyi yuvarlat
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 170,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 103, 103, 104),
                ),
                child: Center(
                    child: Column(
                  children: [
                    /*Container(
                      height: 80, // CircleAvatar'ın boyutu
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 100, // Genişlik
                        height: 44, // Yükseklik
                      ),
                    ),*/
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 251, 255, 251),
                      radius: 50,
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 100, // Genişlik
                        height: 44, // Yükseklik
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Change of Love",
                      style: TextStyle(
                          color: Color.fromARGB(255, 251, 255, 251),
                          fontSize: 20),
                    )
                  ],
                )
                    /* Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/logo.png'),
                            width: 100, // Genişlik
                            height: 44, // Yükseklik
                          ),
                        ],
                      ),
                      Text(
                        'Change Of Love',
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),*/
                    ),
              ),
            ),
            DrawerListTile(
              titleTxt: "Geliştirici Hakkında",
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeveloperAbout(),
                  ),
                );
              },
            ),
            DrawerListTile(
              titleTxt: "Teklifler",
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Teklifler()),
                );
              },
            ),
            DrawerListTile(
              titleTxt: "Kütüphanem",
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyLibrary(
                      newBook: {},
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              titleTxt: "Takas Ettiklerim",
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TakasEdilenler(),
                  ),
                );
              },
            ),
            DrawerListTile(
              titleTxt: "Takas Edeceklerim",
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TakasEdilecekler(
                      newBook: {},
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              titleTxt: "Okumak İstediklerim",
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OkumakIstedikleri(
                      newBook: {},
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              titleTxt: "CoF Hakkında",
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CofAbout(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String titleTxt;
  final VoidCallback onPressed;
  final Key? key; // Key tipinde key parametresi eklendi
  const DrawerListTile({
    this.key, // super.key yerine key kullanıldı
    //  super.key,
    required this.titleTxt,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListTile(
            title: Text(titleTxt),
            onTap: onPressed,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: Colors.grey[400],
            ),
          )
        ],
      ),
    );
  }
}
