import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomFollowNotification extends StatefulWidget {
  final String userName;
  final String assetName;
  CustomFollowNotification(
      {super.key, required this.userName, required this.assetName});

  @override
  State<CustomFollowNotification> createState() =>
      _CustomFollowNotificationState();
}

class _CustomFollowNotificationState extends State<CustomFollowNotification> {
  bool follow = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage((widget.assetName)),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.userName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Seni takip etmeye başladı. ",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.black54),
              ),
            ],
          ),
          //Spacer(),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: follow == false
                    ? Color.fromARGB(255, 246, 249, 252)
                    : Color.fromARGB(255, 33, 103, 35),
              ),
              onPressed: () {
                setState(() {
                  follow = !follow;
                });
              },
              child: Text(
                follow == false ? "Takip et" : "Takip ediliyor",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: follow == false ? Colors.black : Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
