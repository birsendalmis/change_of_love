import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookDetailPage extends StatefulWidget {
  final String userId;
  final Map<String, String> bookInfo;

  const BookDetailPage({Key? key, required this.bookInfo, required this.userId})
      : super(key: key);

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool _isOfferSent = false;

  void _sendOffer() async {
    try {
      // Firebase Authentication kullanarak mevcut kullanıcı bilgilerini al
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('Kullanıcı oturumu açık değil');
      }

      // Firestore'dan mevcut kullanıcı bilgilerini al
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      String currentUserName = userDoc['username'];
      String currentUserImage = userDoc['profile'];

      // Teklif verilerini hazırla
      Map<String, dynamic> offerData = {
        'bookName': widget.bookInfo['bookName'],
        'offerFromUserId': user.uid,
        'offerFromUserName': currentUserName,
        'offerFromUserImage': currentUserImage,
        // İstenirse daha fazla bilgi eklenebilir
      };

      // Firestore'a teklif verisini kaydet
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId) // Teklif gönderilen kullanıcının ID'si
          .collection('offers') // Teklifler koleksiyonu oluşturulabilir
          .add(offerData);

      // Teklif gönderildiğinde _isOfferSent durumunu güncelle
      setState(() {
        _isOfferSent = true;
      });

      // Kullanıcıya geri bildirim ver
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Teklif gönderildi')),
      );
    } catch (error) {
      print('Teklif gönderme hatası: $error');
      // Hata durumunda kullanıcıya bilgi ver
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Teklif gönderirken bir hata oluştu')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String bookName = widget.bookInfo['bookName'] ?? 'Kitap Adı Yok';
    final String authorName = widget.bookInfo['authorName'] ?? 'Yazar Adı Yok';
    final String bookImage = widget.bookInfo['bookImage'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(bookName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bookImage.isNotEmpty
              ? Image.network(
                  bookImage,
                  height: 300,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.error,
                      size: 100,
                    );
                  },
                )
              : Icon(
                  Icons.camera_alt,
                  size: 100,
                ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  bookName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  authorName,
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: _isOfferSent
                    ? null
                    : () {
                        _sendOffer();
                      },
                child: Visibility(
                  visible: !_isOfferSent,
                  child: Row(
                    children: [
                      Icon(Icons.send),
                      SizedBox(width: 8),
                      Text("Teklif Gönder"),
                    ],
                  ),
                  replacement: Row(
                    children: [
                      Icon(Icons.check),
                      SizedBox(width: 8),
                      Text("Teklif Gönderildi"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
