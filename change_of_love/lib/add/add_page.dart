import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          child: const SizedBox(),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Text("EKLE / DÜZENLE"),
                      Divider(
                        color: Colors.grey,
                      )
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
