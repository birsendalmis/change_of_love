import 'package:change_of_love/screens/search/book_search_page.dart';
import 'package:flutter/material.dart';

class ReadListAdd extends StatefulWidget {
  const ReadListAdd({super.key});

  @override
  State<ReadListAdd> createState() => _ReadListAddState();
}

class _ReadListAddState extends State<ReadListAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Okuma Listesine Ekleme Yap"),
        ),
        body: BookSearchPage());
  }
}
