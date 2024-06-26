import 'package:change_of_love/data/firebase_services/firestor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomUserPost extends StatefulWidget {
  final String postId;
  final String userName;
  final String userAssetName;
  final String postAssetName;
  final String postText;
  final String? city;
  final String? district;

  CustomUserPost(
      {super.key,
      required this.postId,
      required this.userName,
      required this.userAssetName,
      required this.postAssetName,
      required this.postText,
      this.city,
      this.district});

  @override
  State<CustomUserPost> createState() => _CustomUserPostState();
}

class _CustomUserPostState extends State<CustomUserPost> {
  int _likeCount = 0; // Beğeni sayısını tutacak değişken
  int _commentCount = 0;
  bool _isLiked = false;
  bool _isLoading = false;
  TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchLikeCount(); // initState içinde beğeni sayısını alacak metodun çağrılması
    _fetchCommentCount(); // Yorum sayısını alacak metodun çağrılması
    _fetchLikeStatus(); // Beğeni durumunu alacak metodun çağrılması
    // _loadUserLocation(); // Kullanıcı konum bilgisini yükle
  }

  /*Future<void> _loadUserLocation() async {
    try {
      // Firestore'dan kullanıcı bilgilerini al
      Usermodel user = await FirebaseFirestor().getUser();
      setState(() {
        _userLocation = '${user.city ?? ''} - ${user.district ?? ''}';
      });
    } catch (e) {
      print('Error loading user location: $e');
    }
  }*/

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


//_addComment metodu kullanılarak yorumlar Firestore'a kaydedilir
  void _addComment() async {
    if (_commentController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFirestor().comments(
        comment: _commentController.text,
        type: 'posts',
        uidd: widget.postId,
      );
      _commentController.clear();
      _fetchCommentCount();
    } catch (e) {
      print('Error adding comment: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Stream<List<Map<String, dynamic>>> _getCommentsStream() {
    return FirebaseFirestor()
        .firebaseFirestore
        .collection('posts')
        .doc(widget.postId)
        .collection('comments')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.city ?? 'İl'),
                            Text(" - "),
                            Text(widget.district ?? 'İlçe')
                          ],
                        )
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
              Flexible(
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "${widget.userName}: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: widget.postText,
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: 'Yorum yaz...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _addComment,
              ),
            ],
          ),
        ),
        StreamBuilder<List<Map<String, dynamic>>>(
          stream: _getCommentsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Yorumlar yüklenemedi');
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('Henüz yorum yok');
            }
            final comments = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(comment['profileImage'] ?? ''),
                  ),
                  title: Text(comment['username']),
                  subtitle: Text(comment['comment']),
                );
              },
            );
          },
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
