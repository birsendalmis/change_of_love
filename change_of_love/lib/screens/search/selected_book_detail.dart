import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final Map<String, String> bookInfo;

  const BookDetailPage({Key? key, required this.bookInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookInfo['bookName'] ?? 'Book Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Book Name: ${bookInfo['bookName'] ?? ''}'),
            Text('Author: ${bookInfo['authorName'] ?? ''}'),
            // Diğer kitap detayları buraya eklenebilir
          ],
        ),
      ),
    );
  }
}
