import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomLikedNotification extends StatefulWidget {
  final String bookAssetName;
  final String userAsset1;
  final String userAsset2;
  final String userName1;
  final String userName2;

  CustomLikedNotification(
      {super.key,
      required this.bookAssetName,
      required this.userAsset1,
      required this.userAsset2,
      required this.userName1,
      required this.userName2});

  @override
  State<CustomLikedNotification> createState() =>
      _CustomLikedNotificationState();
}

class _CustomLikedNotificationState extends State<CustomLikedNotification> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(widget.userAsset1),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(widget.userAsset2),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  maxLines: 2,
                  text: TextSpan(
                      text: widget.userName1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                      children: [
                        TextSpan(
                          text: " ve \n",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                        TextSpan(
                          text: widget.userName2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Gönderini beğendi.  ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black54),
                ),
              ],
            ),
          ),
          Image.asset(
            widget.bookAssetName,
            height: 64,
            width: 64,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
