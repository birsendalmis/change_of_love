import 'package:flutter/material.dart';

class LibraryAdd extends StatefulWidget {
  const LibraryAdd({super.key});

  @override
  State<LibraryAdd> createState() => _LibraryAddState();
}

class _LibraryAddState extends State<LibraryAdd> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Library List Add"),
      ),
    );
  }
}
