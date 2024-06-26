import 'package:change_of_love/screens/profile_page/selected_profile_page.dart';
import 'package:change_of_love/widgets/custom_follow_notification.dart';
import 'package:change_of_love/widgets/custom_liked_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // List newItem = ["liked", "follow"];
  //List todayItem = ["follow", "liked", "liked"];
  // List oldesItem = ["follow"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bildirimler",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Yeni",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(
                height: 10,
              ),
              /* ListView.builder(
                  shrinkWrap: true,
                  itemCount: newItem.length,
                  itemBuilder: (context, index) {
                    return newItem[index] == "follow"
                        ? CustomFollowNotification()
                        : CustomLikedNotification();
                  }),*/
              CustomLikedNotification(
                  bookAssetName: "assets/images/book1.jpeg",
                  userAsset1: "assets/images/mero.jpg",
                  userAsset2: "assets/images/fato.jpg",
                  userName1: "Merve Nur Demir",
                  userName2: "Fatma ÇAKIR"),
              GestureDetector(
                onTap: () {},
                child: CustomFollowNotification(
                    userName: "Alper Doruk",
                    assetName: "assets/images/alper.jpg"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Bugün",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              CustomLikedNotification(
                  bookAssetName: "assets/images/book2.jpeg",
                  userAsset1: "assets/images/atilla.jpg",
                  userAsset2: "assets/images/mero.jpg",
                  userName1: "Atilla AK",
                  userName2: "Merve Nur Demir"),
              CustomFollowNotification(
                  userName: "Fatma ÇAKIR", assetName: "assets/images/fato.jpg"),
              CustomLikedNotification(
                  bookAssetName: "assets/images/dune.jpeg",
                  userAsset1: "assets/images/fato.jpg",
                  userAsset2: "assets/images/atilla.jpg",
                  userName1: "Fatma ÇAKIR",
                  userName2: "Atilla AK"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Daha önce",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              CustomFollowNotification(
                  userName: "Atilla AK", assetName: "assets/images/atilla.jpg"),
            ],
          ),
        ),
      ),
    );
  }
}
