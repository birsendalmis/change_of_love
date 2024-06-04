import 'package:change_of_love/constants/colors.dart';
import 'package:change_of_love/screens/home_page/home_page.dart';
import 'package:change_of_love/screens/message_page/message_detail.dart';
import 'package:change_of_love/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mesajlar",
          style: TextStyle(
              color: AppColors.textColorWhite,
              fontWeight: FontWeight.w500,
              fontSize: 25),
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 138, 173, 136),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: AppColors.textColorWhite,
          ),
        ),
        actions: [
          CustomIconButton(
              iconsData: Icons.search,
              iconSize: 35,
              onTap: () {},
              iconColor: AppColors.textColorWhite)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessageDetails()),
                );
              },
              child: MessageCard(
                assetName: "assets/images/alper.jpg",
                userName: "Alper Doruk",
                messageText: "Karar verince bilgilendireceğim :).",
                messageTime: "23:00",
              ),
            ),
            MessageCard(
              assetName: "assets/images/atilla.jpg",
              userName: "Atilla AK",
              messageText: "Yanıtınızı bekliyorum :)",
              messageTime: "20:08",
            ),
            MessageCard(
              assetName: "assets/images/mero.jpg",
              userName: "Merve DEMİR",
              messageText: "Küçük prens için takas düşünür müsün?",
              messageTime: "09:46",
            ),
            MessageCard(
              assetName: "assets/images/fato.jpg",
              userName: "Fatma ÇAKIR",
              messageText: "Teşekkürler.",
              messageTime: "02:06",
            ),
          ],
        ),
      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  final String assetName;
  final String userName;
  final String messageText;
  final String messageTime;
  const MessageCard({
    super.key,
    required this.assetName,
    required this.userName,
    required this.messageText,
    required this.messageTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(assetName),
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      messageText,
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  messageTime,
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Divider(
          thickness: 0.5,
        )
      ],
    );
  }
}
