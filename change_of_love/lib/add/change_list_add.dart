import 'package:flutter/material.dart';

class ChangeListAdd extends StatefulWidget {
  const ChangeListAdd({super.key});

  @override
  State<ChangeListAdd> createState() => _ChangeListAddState();
}

class _ChangeListAddState extends State<ChangeListAdd> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Change List Add"),
      ),
    );
  }
}
