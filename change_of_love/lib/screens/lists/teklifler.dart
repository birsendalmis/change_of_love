import 'package:change_of_love/widgets/custom_teklif_list_tile.dart';
import 'package:flutter/material.dart';

class Teklifler extends StatefulWidget {
  const Teklifler({super.key});

  @override
  State<Teklifler> createState() => _TekliflerState();
}

class _TekliflerState extends State<Teklifler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "TEKLİFLER",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 204, 239, 202),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TeklifListTile(
              userAssetName: "assets/images/mero.jpg",
              userName: "Merve Nur Demir",
              bookAssetName: "assets/images/app_book1.jpeg",
            ),
            TeklifListTile(
              userAssetName: "assets/images/fato.jpg",
              userName: "Fatma ÇAKIR",
              bookAssetName: "assets/images/app_book2.jpeg",
            ),
            TeklifListTile(
              userAssetName: "assets/images/atilla.jpg",
              userName: "Atilla AK",
              bookAssetName: "assets/images/app_book4.jpeg",
            ),
            TeklifListTile(
              userAssetName: "assets/images/mero.jpg",
              userName: "Merve Nur Demir",
              bookAssetName: "assets/images/app_book3.jpeg",
            ),
            TeklifListTile(
              userAssetName: "assets/images/mero.jpg",
              userName: "Merve Nur Demir",
              bookAssetName: "assets/images/app_book4.jpeg",
            ),
            TeklifListTile(
              userAssetName: "assets/images/atilla.jpg",
              userName: "Atilla AK",
              bookAssetName: "assets/images/app_book2.jpeg",
            ),
            TeklifListTile(
              userAssetName: "assets/images/alper.jpg",
              userName: "Alper Doruk",
              bookAssetName: "assets/images/app_book4.jpeg",
            ),
            TeklifListTile(
              userAssetName: "assets/images/mero.jpg",
              userName: "Merve Nur Demir",
              bookAssetName: "assets/images/app_book2.jpeg",
            ),
            TeklifListTile(
              userAssetName: "assets/images/fato.jpg",
              userName: "Fatma ÇAKIR",
              bookAssetName: "assets/images/app_book4.jpeg",
            ),
            TeklifListTile(
              userAssetName: "assets/images/alper.jpg",
              userName: "Alper Doruk",
              bookAssetName: "assets/images/app_book1.jpeg",
            ),
            TeklifListTile(
              userAssetName: "assets/images/atilla.jpg",
              userName: "Atilla AK",
              bookAssetName: "assets/images/app_book3.jpeg",
            ),
            TeklifListTile(
              userAssetName: "assets/images/fato.jpg",
              userName: "Fatma ÇAKIR",
              bookAssetName: "assets/images/app_book1.jpeg",
            ),
          ],
        ),
      ),
    );
  }
}
