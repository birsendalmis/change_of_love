import 'package:change_of_love/constants/colors.dart';
import 'package:change_of_love/screens/profile_page/settings.dart';
import 'package:change_of_love/widgets/custom_icon_button.dart';
import 'package:change_of_love/widgets/custom_list_button.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 138, 173, 136),
        actions: [
          CustomIconButton(
              iconsData: Icons.settings,
              iconSize: 35,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
              iconColor: AppColors.textColorWhite)
        ],
      ),
      body: SizedBox(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 138, 173, 136),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                  ),
                  height: 300,
                  child: const Column(
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/images/logo.png"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Kullanıcı Adı"),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text("354"),
                              Text("Takipçi"),
                            ],
                          ),
                          Column(
                            children: [
                              Text("354"),
                              Text("Takip Edilen"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 200,
                ),
                //Liste isimlerinin butonları
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ListsButton(
                        btnHeight: 40,
                        btnWidth: 120,
                        onTap: () {},
                        btnText: "Kütüphanem",
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ListsButton(
                        btnHeight: 40,
                        btnWidth: 120,
                        onTap: () {},
                        btnText: "Okumak İstediklerim",
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ListsButton(
                        btnHeight: 40,
                        btnWidth: 120,
                        onTap: () {},
                        btnText: "Takas Edilenler",
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ListsButton(
                        btnHeight: 40,
                        btnWidth: 120,
                        onTap: () {},
                        btnText: "Takas Edilecekler",
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 240,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 175, 214, 239),
                      borderRadius: BorderRadius.circular(20)),
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const Expanded(
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    "Hakkında",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                    overflow: TextOverflow.visible,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                icon: const Icon(Icons.person_add_alt),
                                label: const Text("Takip Et"))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
