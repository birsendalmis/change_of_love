import 'package:change_of_love/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:change_of_love/data/firebase_services/firestor.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhotoDetailPage extends StatefulWidget {
  final String postId;
  final String userName;
  final String userAssetName;
  final String postAssetName;
  final String postText;

  PhotoDetailPage({
    required this.postId,
    required this.userName,
    required this.userAssetName,
    required this.postAssetName,
    required this.postText,
  });

  @override
  _PhotoDetailPageState createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  int _likeCount = 0;
  int _commentCount = 0;
  bool _isLiked = false;
  bool _isLoading = false;
  String? _userLocation;

  @override
  void initState() {
    super.initState();
    _fetchLikeCount();
    _fetchCommentCount();
    _fetchLikeStatus();
    _loadUserLocation();
  }

  Future<void> _loadUserLocation() async {
    try {
      Usermodel user = await FirebaseFirestor().getUser();
      setState(() {
        _userLocation = '${user.city ?? ''} - ${user.district ?? ''}';
      });
    } catch (e) {
      print('Error loading user location: $e');
    }
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 239, 254, 255),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(widget.userAssetName),
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
                        if (_userLocation != null)
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
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.2,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.postAssetName,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Text('Fotoğraf yüklenemedi'));
                },
              ),
            ),
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "${widget.userName}: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: widget.postText),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
