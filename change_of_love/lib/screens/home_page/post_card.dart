import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 90,
            child: Row(
              //pp nin olduğu yer
              children: [
                CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/images/logo.png")),
                Column(
                  children: [
                    Text("İsim soyisim"),
                    Text("@kullanıcıadı"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: Row(
              //iç kısım
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 100,
                  width: 70,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/logo.png"),
                        const Column(
                          children: [
                            Text("data"),
                            Text(
                              "data",
                            )
                          ],
                        ),
                      ],
                    ),
                    const Text("data"),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite_border),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(Icons.insert_comment_outlined),
                  ],
                ),
                Center(
                  child: Row(
                    children: [
                      Icon(Icons.arrow_outward),
                      Text("Teklif Gönder"),
                    ],
                  ),
                ),
                Spacer(),
                Positioned(right: 5, child: Icon(Icons.more_vert))
              ],
            ),
          )
        ],
      ),
    );
  }
}
