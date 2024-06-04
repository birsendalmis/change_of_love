import 'package:change_of_love/data/firebase_services/firestor.dart';
import 'package:change_of_love/util/image_cached.dart';
import 'package:change_of_love/widgets/comment.dart';
import 'package:change_of_love/widgets/like_animation.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final snapshot;
  PostCard({super.key, this.snapshot});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  bool isAnimating = false;

  String user = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = _auth.currentUser!.uid;
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 375,
          height: 54,
          color: Colors.white,
          child: Center(
            child: ListTile(
              leading: ClipOval(
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: CachedImage(widget.snapshot['profileImage']),
                ),
              ),
              title: Text(
                widget.snapshot['username'],
                style: const TextStyle(fontSize: 13),
              ),
              subtitle: Text(
                widget.snapshot['location'],
                style: const TextStyle(fontSize: 11),
              ),
              trailing: const Icon(Icons.more_horiz),
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            FirebaseFirestor().like(
                like: widget.snapshot['like'],
                type: 'posts',
                uid: user,
                postId: widget.snapshot['postId']);
            setState(() {
              isAnimating = true;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 375,
                height: 375,
                child: CachedImage(
                  widget.snapshot['postImage'],
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isAnimating ? 1 : 0,
                child: LikeAnimation(
                  child: const Icon(
                    Icons.favorite,
                    size: 100,
                    color: Colors.red,
                  ),
                  isAnimating: isAnimating,
                  duration: const Duration(milliseconds: 400),
                  iconlike: false,
                  End: () {
                    setState(() {
                      isAnimating = false;
                    });
                  },
                ),
              )
            ],
          ),
        ),
        Container(
          width: 375,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),
              Row(
                children: [
                  const SizedBox(width: 14),
                  LikeAnimation(
                    child: IconButton(
                      onPressed: () {
                        FirebaseFirestor().like(
                            like: widget.snapshot['like'],
                            type: 'posts',
                            uid: user,
                            postId: widget.snapshot['postId']);
                      },
                      icon: Icon(
                        widget.snapshot['like'].contains(user)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.snapshot['like'].contains(user)
                            ? Colors.red
                            : Colors.black,
                        size: 24,
                      ),
                    ),
                    isAnimating: widget.snapshot['like'].contains(user),
                  ),
                  const SizedBox(width: 17),
                  GestureDetector(
                    onTap: () {
                      showBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: DraggableScrollableSheet(
                              maxChildSize: 0.6,
                              initialChildSize: 0.6,
                              minChildSize: 0.2,
                              builder: (context, scrollController) {
                                return Comment(
                                    widget.snapshot['postId'], 'posts');
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Image.asset(
                      'assets/images/comment.webp',
                      height: 28,
                    ),
                  ),
                  const SizedBox(width: 17),
                  Image.asset(
                    'assets/images/send.png',
                    height: 28,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Image.asset(
                      'assets/images/save.png',
                      height: 28,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  top: 4,
                  bottom: 8,
                ),
                child: Text(
                  widget.snapshot['like'].length.toString(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.snapshot['username'] +
                            ' :  ' +
                            widget.snapshot['caption'],
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 20, bottom: 8),
                child: Text(
                  formatDate(widget.snapshot['time'].toDate(),
                      [yyyy, '-', mm, '-', dd]),
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    /*SizedBox(
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
    );*/
  }
}
