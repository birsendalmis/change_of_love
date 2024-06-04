import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomBookListTile extends StatefulWidget {
  final String authorName;
  final String bookName;
  final String bookImage;
  CustomBookListTile(
      {super.key,
      required this.authorName,
      required this.bookName,
      required this.bookImage});

  @override
  State<CustomBookListTile> createState() => _CustomBookListTileState();
}

class _CustomBookListTileState extends State<CustomBookListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            child: widget.bookImage.isNotEmpty
                ? Image.network(
                    widget.bookImage,
                    fit: BoxFit.cover,
                  )
                : Icon(
                    Icons.camera_alt,
                    size: 70,
                  ),
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
                  overflow: TextOverflow.ellipsis,
                  "Adı: ${widget.bookName}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  "Yazar: ${widget.authorName}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black54),
                ),
              ],
            ),
          ),
          //Spacer(),

          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
