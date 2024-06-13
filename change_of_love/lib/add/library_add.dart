import 'package:change_of_love/screens/search/book_search_page.dart';
import 'package:flutter/material.dart';

class LibraryAdd extends StatefulWidget {
  const LibraryAdd({super.key});

  @override
  State<LibraryAdd> createState() => _LibraryAddState();
}

class _LibraryAddState extends State<LibraryAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Kütüphaneye Ekleme Yap"),
        ),
        body: BookSearchPage());
  }
}
