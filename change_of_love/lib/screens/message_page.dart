import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Message Page",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
