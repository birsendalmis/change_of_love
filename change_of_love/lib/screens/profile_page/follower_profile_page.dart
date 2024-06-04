import 'package:change_of_love/screens/message_page/message_detail.dart';
import 'package:change_of_love/widgets/custom_list_button.dart';
import 'package:flutter/material.dart';

class followerProfile extends StatefulWidget {
  const followerProfile({super.key});

  @override
  State<followerProfile> createState() => _followerProfileState();
}

class _followerProfileState extends State<followerProfile> {
  bool follow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 204, 239, 202),
      ),
      body: SizedBox(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 204, 239, 202),
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
                                AssetImage("assets/images/alper.jpg"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Alper Doruk",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
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
                              Text(
                                "549",
                              ),
                              Text(
                                "Takipçi",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text("138"),
                              Text(
                                "Takip Edilen",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
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
                        btnText: "Gönderiler",
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ListsButton(
                        btnHeight: 40,
                        btnWidth: 120,
                        onTap: () {},
                        btnText: "Kütüphane",
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ListsButton(
                        btnHeight: 40,
                        btnWidth: 120,
                        onTap: () {},
                        btnText: "Okumak İstenenler",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MessageDetails()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 246, 249, 252),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                icon: Icon(Icons.message, color: Colors.black),
                                label: Text(
                                  "Mesaj",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.black),
                                )),
                            ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    follow = !follow;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: follow == false
                                        ? Color.fromARGB(255, 246, 249, 252)
                                        : Color.fromARGB(255, 33, 103, 35),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                icon: Icon(Icons.person_add_alt,
                                    color: follow == false
                                        ? Colors.black
                                        : Colors.white),
                                label: Text(
                                  follow == false
                                      ? "Takip et"
                                      : "Takip ediliyor",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: follow == false
                                          ? Colors.black
                                          : Colors.white),
                                ))
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
