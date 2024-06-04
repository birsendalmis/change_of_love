import 'package:change_of_love/screens/search/search_page.dart';
import 'package:flutter/material.dart';

class ChangeListAdd extends StatefulWidget {
  const ChangeListAdd({super.key});

  @override
  State<ChangeListAdd> createState() => _ChangeListAddState();
}

class _ChangeListAddState extends State<ChangeListAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Takas Listesine Ekleme Yap"),
        ),
        body: SearchPage());
  }
}
