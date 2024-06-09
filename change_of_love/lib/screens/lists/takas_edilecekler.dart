import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TakasEdilecekler extends StatefulWidget {
  final Map<String, String> newBook;
  const TakasEdilecekler({super.key, required this.newBook});

  @override
  State<TakasEdilecekler> createState() => _TakasEdileceklerState();
}

class _TakasEdileceklerState extends State<TakasEdilecekler> {
  List<Map<String, String>> books = [];

  @override
  void initState() {
    super.initState();
    loadBooks();
    // Eklenen yeni kitabı listeye ekleyin
    if (widget.newBook.isNotEmpty) {
      books.add(widget.newBook);
    }
  }

  Future<void> loadBooks() async {
    print('loadBooks is called');
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? savedBooks =
          prefs.getStringList('takas_edileceklerim');
      if (savedBooks != null) {
        setState(() {
          books = savedBooks
              .where((book) => book.isNotEmpty && _isValidJson(book))
              .map((jsonString) =>
                  Map<String, String>.from(json.decode(jsonString)))
              .toList();
        });
      }
    } catch (error) {
      print('loadBooks Error: $error');
    }
  }

  bool _isValidJson(String jsonString) {
    try {
      json.decode(jsonString);
      return true;
    } catch (e) {
      print('Invalid JSON: $jsonString');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "TAKAS EDECEKLERİM",
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
                return ListTile(
                  title: Text(book['bookName'] ?? ''),
                  subtitle: Text(book['authorName'] ?? ''),
                  leading: Image.network(book['bookImage'] ?? ''),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
