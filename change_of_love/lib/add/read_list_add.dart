import 'package:flutter/material.dart';

class ReadListAdd extends StatefulWidget {
  const ReadListAdd({super.key});

  @override
  State<ReadListAdd> createState() => _ReadListAddState();
}

class _ReadListAddState extends State<ReadListAdd> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Read List Add"),
      ),
    );
  }
}
