import 'dart:io';
import 'package:change_of_love/screens/home_page/home_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:change_of_love/data/firebase_services/firestor.dart';

class NextPage extends StatefulWidget {
  final String imagePath;

  const NextPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  TextEditingController _captionController = TextEditingController();
  FirebaseFirestor _firebaseFirestore = FirebaseFirestor();
  bool _isUploading = false;

  Future<String> _uploadImage(File image) async {
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child("posts/${DateTime.now().millisecondsSinceEpoch}.jpg");
    final UploadTask uploadTask = storageRef.putFile(image);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _share() async {
    setState(() {
      _isUploading = true;
    });
    try {
      final String caption = _captionController.text;
      final String postImage = await _uploadImage(File(widget.imagePath));
      final String location = "";
      final String city = "";
      final String district = "";
      final int likeCount = 0;
      final int commentCount = 0;
      final DateTime time = DateTime.now();

      bool result = await _firebaseFirestore.createPost(
        city: city,
        district: district,
        postImage: postImage,
        caption: caption,
        location: location,
        likeCount: likeCount,
        commentCount: commentCount,
        time: time,
      );

      if (result) {
        // Gönderi başarıyla paylaşıldığında HomePage'a yönlendirme yapılır
        Navigator.pushReplacement(
          // Mevcut sayfanın yerine HomePage'a geçiş yapar
          context,
          MaterialPageRoute(
              builder: (context) => HomePage()), // HomePage'a yönlendirme
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gönderi paylaşımı başarısız oldu.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bir hata oluştu: $e'),
        ),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.file(File(widget.imagePath)),
            SizedBox(height: 20),
            TextField(
              controller: _captionController,
              decoration: InputDecoration(
                hintText: 'Açıklama',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isUploading ? null : _share,
              child:
                  _isUploading ? CircularProgressIndicator() : Text('Paylaş'),
            ),
          ],
        ),
      ),
    );
  }
}
