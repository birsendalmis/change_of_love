import 'package:change_of_love/screens/profile_page/profile_page.dart';
import 'package:change_of_love/widgets/custom_elevated_button.dart';
import 'package:change_of_love/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("assets/images/birsen.jpeg"),
          ),
          Text("Birsen DALMIŞ")
        ],
      ),
      content: const SizedBox(
        height: 170,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("354"),
                      Text(
                        "Takip",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("237"),
                      Text(
                        "Kütüphanem",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("17634"),
                      Text(
                        "Takipçi",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("152"),
                      Text(
                        "Okuma Listem",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            CustomTextButton(
              btntext: "Kapat",
              btnTxtColor: Colors.red,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            CustomElevatedButton(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
              btnText: "Hesap Detay",
              btnWidth: 10,
              btnHeight: 35,
              btnColor: const Color.fromARGB(255, 124, 176, 126),
            )
          ],
        ),
      ],
    );
  }
}
