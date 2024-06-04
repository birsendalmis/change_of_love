import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TeklifListTile extends StatefulWidget {
  final String bookAssetName;
  final String userAssetName;

  final String userName;
  TeklifListTile(
      {super.key,
      required this.bookAssetName,
      required this.userName,
      required this.userAssetName});

  @override
  State<TeklifListTile> createState() => _TeklifListTileState();
}

class _TeklifListTileState extends State<TeklifListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage((widget.userAssetName)),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
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
                  "Kitabınıza teklif gönderdi.",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black54),
                ),
              ],
            ),
          ),
          //Spacer(),
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
