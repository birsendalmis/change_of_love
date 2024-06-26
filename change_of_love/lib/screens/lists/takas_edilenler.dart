import 'package:change_of_love/widgets/custom_takas_edilenler_tile.dart';
import 'package:flutter/material.dart';

class TakasEdilenler extends StatefulWidget {
  const TakasEdilenler({super.key});

  @override
  State<TakasEdilenler> createState() => _TakasEdilenlerState();
}

class _TakasEdilenlerState extends State<TakasEdilenler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Geri tuşuna basıldığında
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Profil sayfasından çık
              },
            ),

            Center(
              child: Text(
                "TAKAS ETTİKLERİM",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 204, 239, 202),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomTakasEdilenlerTile(
                bookAssetName: "assets/images/takas1.jpeg",
                userName: "Fatma ÇAKIR",
                userAssetName: "assets/images/fato.jpg"),
            CustomTakasEdilenlerTile(
                bookAssetName: "assets/images/takas2.jpeg",
                userName: "Alper Doruk",
                userAssetName: "assets/images/alper.jpg"),
            CustomTakasEdilenlerTile(
                bookAssetName: "assets/images/takas3.jpeg",
                userName: "Atilla AK",
                userAssetName: "assets/images/atilla.jpg"),
            CustomTakasEdilenlerTile(
                bookAssetName: "assets/images/takas4.jpeg",
                userName: "Merve Nur Demir",
                userAssetName: "assets/images/mero.jpg"),
          ],
        ),
      ),
    );
  }
}
