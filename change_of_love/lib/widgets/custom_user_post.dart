import 'package:change_of_love/data/firebase_services/firestor.dart';
import 'package:change_of_love/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomUserPost extends StatefulWidget {
  final String postId;
  final String userName;
  final String userAssetName;
  final String postAssetName;
  final String postText;

  CustomUserPost(
      {super.key,
      required this.postId,
      required this.userName,
      required this.userAssetName,
      required this.postAssetName,
      required this.postText});

  @override
  State<CustomUserPost> createState() => _CustomUserPostState();
}

class _CustomUserPostState extends State<CustomUserPost> {
  int _likeCount = 0; // Beğeni sayısını tutacak değişken
  int _commentCount = 0;
  bool _isLiked = false;
  bool _isLoading = false;
  String? _userLocation; // Kullanıcının il-ilçe bilgisi
  @override
  void initState() {
    super.initState();
    _fetchLikeCount(); // initState içinde beğeni sayısını alacak metodun çağrılması
    _fetchCommentCount(); // Yorum sayısını alacak metodun çağrılması
    _fetchLikeStatus(); // Beğeni durumunu alacak metodun çağrılması
    _loadUserLocation(); // Kullanıcı konum bilgisini yükle
  }

  Future<void> _loadUserLocation() async {
    try {
      // Firestore'dan kullanıcı bilgilerini al
      Usermodel user = await FirebaseFirestor().getUser();
      setState(() {
        _userLocation = '${user.city ?? ''} - ${user.district ?? ''}';
      });
    } catch (e) {
      print('Error loading user location: $e');
    }
  }

  // Firestore'dan beğeni sayısını alacak metod
  Future<void> _fetchLikeCount() async {
    try {
      final likeCount = await FirebaseFirestor().getLikeCount(widget.postId);
      setState(() {
        _likeCount = likeCount;
      });
    } catch (e) {
      print('Error fetching like count: $e');
    }
  }

  Future<void> _fetchLikeStatus() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      final isLiked =
          await FirebaseFirestor().isPostLiked(widget.postId, userId);
      setState(() {
        _isLiked = isLiked;
      });
    } catch (e) {
      print('Error fetching like status: $e');
    }
  }

  void _toggleLike() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      if (_isLiked) {
        await FirebaseFirestor().updateLike(
          postId: widget.postId,
          userId: userId,
          isLiked: true,
        );
        setState(() {
          _likeCount -= 1;
          _isLiked = false;
        });
      } else {
        await FirebaseFirestor().updateLike(
          postId: widget.postId,
          userId: userId,
          isLiked: false,
        );
        setState(() {
          _likeCount += 1;
          _isLiked = true;
        });
      }
    } catch (e) {
      print('Error toggling like: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  /*// Beğeni durumunu değiştirecek metod
  void _toggleLike() async {
    if (_isLoading) return; // Hızlı art arda tıklamaları engelle

    setState(() {
      _isLoading = true; // İşlem sırasında diğer tıklamaları engelle
    });

    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      if (_isLiked) {
        await FirebaseFirestor().updateLike(
          postId: widget.postId,
          userId: userId,
          isLiked: true,
        );
        setState(() {
          _likeCount -= 1;
          _isLiked = false;
        });
      } else {
        await FirebaseFirestor().updateLike(
          postId: widget.postId,
          userId: userId,
          isLiked: false,
        );
        setState(() {
          _likeCount += 1;
          _isLiked = true;
        });
      }
    } catch (e) {
      print('Error toggling like: $e');
    } finally {
      setState(() {
        _isLoading =
            false; // İşlem tamamlandıktan sonra tekrar tıklamaları serbest bırak
      });
    }
  }*/

  // Firestore'dan yorum sayısını alacak metod
  Future<void> _fetchCommentCount() async {
    try {
      final commentCount =
          await FirebaseFirestor().getCommentCount(widget.postId);
      setState(() {
        _commentCount = commentCount;
      });
    } catch (e) {
      print('Error fetching comment count: $e');
    }
  }

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
                      padding: const EdgeInsets.all(3),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(widget
                            .userAssetName), // Profil fotoğrafı URL'den yükleniyor
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_userLocation !=
                            null) // Eğer konum bilgisi varsa göster
                          Text(
                            _userLocation!,
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 127, 127, 127),
                            ),
                          ),
                      ],
                    ),
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
          child: Image.network(
            widget.postAssetName, // Gönderi fotoğrafı URL'den yükleniyor
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(child: Text('Fotoğraf yüklenemedi'));
            },
          ),
        ),

        //buttons and comments
        Container(
          color: Color.fromARGB(255, 239, 254, 255),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: _isLiked
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border),
                      onPressed: _toggleLike,
                    ),
                    SizedBox(width: 5),
                    Text(_likeCount.toString()),
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
                    Text(_commentCount.toString()),
                  ],
                ),
                Spacer(),
                /* RatingBar.builder(
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
                )*/
              ],
            ),
          ),
        ),
        //caption
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText(
                text:
                    TextSpan(style: TextStyle(color: Colors.black), children: [
                  TextSpan(
                    text: "${widget.userName}: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: widget.postText,
                  )
                ]),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
