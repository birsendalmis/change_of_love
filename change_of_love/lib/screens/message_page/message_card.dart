import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final String assetName;    // Mesajlaşılan kişinin profil fotoğrafı
  final String userName;     // Mesajlaşılan kişinin kullanıcı adı
  final String messageText;  // Mesajlaşılan kişi ile olan son mesaj
  final String messageTime;  // Son atılan mesajın saati

  const MessageCard({
    Key? key,
    required this.assetName,
    required this.userName,
    required this.messageText,
    required this.messageTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(assetName), // Profil fotoğrafı için NetworkImage kullanılmalı
              ),
              SizedBox(width: 10),
              Expanded(
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
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Text(
                messageTime,
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Divider(thickness: 0.5),
      ],
    );
  }
}
