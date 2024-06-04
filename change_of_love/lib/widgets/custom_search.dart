import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  const CustomSearchBar(
      {super.key,
      required this.controller,
      required this.onChanged,
      required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.zero,
          hintText: 'Arama yap...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}
