import 'package:flutter/material.dart';

class CustomTakasEdilenlerTile extends StatefulWidget {
  final String userAssetName;
  final String userName;
  final String bookAssetName;
  CustomTakasEdilenlerTile(
      {super.key,
      required this.userAssetName,
      required this.userName,
      required this.bookAssetName});

  @override
  State<CustomTakasEdilenlerTile> createState() =>
      _CustomTakasEdilenlerTileState();
}

class _CustomTakasEdilenlerTileState extends State<CustomTakasEdilenlerTile> {
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
                  "ile takas gerçekleştirildi",
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
