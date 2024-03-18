import 'package:flutter/material.dart';

class DeveloperAbout extends StatelessWidget {
  const DeveloperAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Developer About",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
