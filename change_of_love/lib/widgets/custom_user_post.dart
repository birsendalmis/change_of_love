import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomUserPost extends StatefulWidget {
  final String userName;
  final String userAssetName;
  final String postAssetName;
  final String postText;

  CustomUserPost(
      {super.key,
      required this.userName,
      required this.userAssetName,
      required this.postAssetName,
      required this.postText});

  @override
  State<CustomUserPost> createState() => _CustomUserPostState();
}

class _CustomUserPostState extends State<CustomUserPost> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color.fromARGB(255, 239, 254, 255),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage((widget.userAssetName)),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.userName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Spacer(),
                Icon(Icons.more_vert),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ),

        //post
        Container(
          height: MediaQuery.of(context).size.height / 2.2,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            widget.postAssetName,
            fit: BoxFit.cover,
          ),
        ),
        //buttons and comments
        Container(
          color: Color.fromARGB(255, 239, 254, 255),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite_border),
                    SizedBox(
                      width: 5,
                    ),
                    Text("111"),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Row(
                  children: [
                    Icon(Icons.mode_comment_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text("8 yorum"),
                  ],
                ),
                Spacer(),
                RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Icon(Icons.star, color: Colors.amber);
                  },
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )
              ],
            ),
          ),
        ),
        //caption
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
              text: TextSpan(style: TextStyle(color: Colors.black), children: [
            TextSpan(
              text: widget.userName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: widget.postText)
          ])),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
