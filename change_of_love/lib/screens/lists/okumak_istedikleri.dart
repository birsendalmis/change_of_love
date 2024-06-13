import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OkumakIstedikleri extends StatefulWidget {
  final Map<String, String> newBook;
  const OkumakIstedikleri({Key? key, required this.newBook}) : super(key: key);

  @override
  State<OkumakIstedikleri> createState() => _OkumakIstedikleriState();
}

class _OkumakIstedikleriState extends State<OkumakIstedikleri> {
  List<Map<String, String>> books = [];

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {
    print('loadBooks is called');
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final QuerySnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('okumak_istedikleri')
                .get();

        setState(() {
          books = snapshot.docs.map((doc) {
            final data = doc.data();
            data['documentId'] =
                doc.id; // Belge kimliğini kitap verilerine ekle
            return Map<String, String>.from(data);
          }).toList();
          // Eklenen yeni kitabı listeye ekleyin
          if (widget.newBook.isNotEmpty) {
            books.add(widget.newBook);
          }
        });
      }
    } catch (error) {
      print('loadBooks Error: $error');
    }
  }

  void _deleteBook(String documentId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Firebase'den kitabı kaldır
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('okumak_istedikleri')
            .doc(documentId) // Belge kimliği üzerinden kaldır
            .delete();

        // Yerel listeden kitabı kaldır
        setState(() {
          books.removeWhere((book) => book['documentId'] == documentId);
        });
      }
    } catch (error) {
      print('Delete book error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "OKUMAK İSTEDİKLERİM",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 204, 239, 202),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Kitap listesi için ListView.builder kullanın
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final bookImage = book['bookImage'] ?? '';
                return ListTile(
                  title: Text(book['bookName'] ?? ''),
                  subtitle: Text(book['authorName'] ?? ''),
                  leading: bookImage.isNotEmpty
                      ? Image.network(bookImage,
                          errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error);
                        })
                      : const Icon(Icons.camera_alt),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteBook(book['documentId']!);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
