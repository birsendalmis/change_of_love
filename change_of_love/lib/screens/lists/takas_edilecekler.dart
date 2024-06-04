import 'package:change_of_love/widgets/custom_book_list_tile.dart';
import 'package:flutter/material.dart';

class TakasEdilecekler extends StatefulWidget {
  const TakasEdilecekler({super.key});

  @override
  State<TakasEdilecekler> createState() => _TakasEdileceklerState();
}

class _TakasEdileceklerState extends State<TakasEdilecekler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "TAKAS EDECEKLERİM",
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
            /* CustomBookListTile(
                authorName: "Joseph Murphy",
                bookName: "Bilinçaltının Gücü ",
                bookAssetName: "assets/images/app_book7.jpeg"),
            CustomBookListTile(
                authorName: "Mert Arık",
                bookName: "Çantamdan Fil Çıktı",
                bookAssetName: "assets/images/app_book8.jpeg"),
            CustomBookListTile(
                authorName: "Sharon M. Draper",
                bookName: "İçimdeki Müzik",
                bookAssetName: "assets/images/app_book9.jpeg"),
            CustomBookListTile(
                authorName: "Jeffrey E. Young , Janet Klosko",
                bookName: "Hayatı Yeniden Keşfedin",
                bookAssetName: "assets/images/app_book10.jpeg"),
            CustomBookListTile(
                authorName: "Yu Hua",
                bookName: "Yaşamak",
                bookAssetName: "assets/images/app_book11.jpeg"),
            CustomBookListTile(
                authorName: "Paulo Coelho",
                bookName: "Simyacı",
                bookAssetName: "assets/images/app_book12.jpeg"),
            CustomBookListTile(
                authorName: "Hwang Bo - Reum",
                bookName: "Hyunam - Dong Kitabevi",
                bookAssetName: "assets/images/app_book13.jpeg"),
            CustomBookListTile(
                authorName: "Anthony Burgess",
                bookName: "Otomatik Portakal",
                bookAssetName: "assets/images/app_book14.jpeg"),
            CustomBookListTile(
                authorName: "Doğan Cüceloğlu",
                bookName: "Var mısın?",
                bookAssetName: "assets/images/app_book15.jpeg"),
            CustomBookListTile(
                authorName: "Mert Arık",
                bookName: "Uzaya Giden Tren",
                bookAssetName: "assets/images/app_book16.jpeg"),*/
          ],
        ),
      ),
    );
  }
}
