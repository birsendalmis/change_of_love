import 'dart:convert';
import 'package:change_of_love/screens/lists/okumak_istedikleri.dart';
import 'package:change_of_love/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookDetailsPage extends StatefulWidget {
  final Map<String, dynamic> volumeInfo;
  const BookDetailsPage({Key? key, required this.volumeInfo}) : super(key: key);

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  late final Map<String, dynamic> volumeInfo;

  @override
  void initState() {
    super.initState();
    volumeInfo = widget.volumeInfo;
  }

  Future<void> addToReadingList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? readingList =
        prefs.getStringList('okumak_istediklerim') ?? [];

    // Kitap bilgilerini JSON formatında oluştur
    final Map<String, String> bookInfo = {
      'bookName': volumeInfo['title'] ?? '',
      'authorName':
          volumeInfo['authors'] != null ? volumeInfo['authors'].join(', ') : '',
      'bookImage': volumeInfo['imageLinks']?['thumbnail'] ?? '',
    };

    // Kitap bilgilerini JSON formatına dönüştür
    final jsonString = jsonEncode(bookInfo);

    // JSON formatındaki kitap bilgilerini listeye ekle
    readingList?.add(jsonString);

    // Güncellenmiş okumak istedikleri listesini kaydet
    await prefs.setStringList('okumak_istediklerim', readingList!);

    // Okumak istedikleri sayfasına yönlendir ve yeni kitabı göster
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OkumakIstedikleri(newBook: bookInfo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.volumeInfo['title'] ?? '-'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: widget.volumeInfo['imageLinks'] != null
                  ? Image.network(
                      widget.volumeInfo['imageLinks']['thumbnail'],
                      width: 150,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.camera_alt, size: 50),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text("Eser Adı:"),
                Text(
                  ' ${widget.volumeInfo['title'] ?? '-'}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
                'Yazar / Yazarlar: ${widget.volumeInfo['authors']?.join(', ') ?? '-'}'),
            Text('Yayımcı: ${widget.volumeInfo['publisher'] ?? '-'}'),
            Text(
                'Yayınlanma Tarihi: ${widget.volumeInfo['publishedDate'] ?? '-'}'),
            Text('Dil: ${widget.volumeInfo['language'] ?? '-'}'),
            Text('Sayfa Sayısı: ${widget.volumeInfo['pageCount'] ?? '-'}'),
            SizedBox(height: 30),
            Column(
              children: [
                Text("Listeye Ekle",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Divider(thickness: 1),
                CustomElevatedButton(
                  onTap: () {},
                  btnText: "Kütüphane",
                  btnHeight: 30,
                  btnColor: const Color.fromARGB(255, 232, 187, 119),
                ),
                CustomElevatedButton(
                  onTap: () {
                    addToReadingList();
                  },
                  btnText: "Okumak İstenenler",
                  btnHeight: 30,
                  btnColor: const Color.fromARGB(255, 232, 187, 119),
                ),
                CustomElevatedButton(
                  onTap: () {},
                  btnText: "Takas Edilenler",
                  btnHeight: 30,
                  btnColor: const Color.fromARGB(255, 232, 187, 119),
                ),
                CustomElevatedButton(
                  onTap: () {},
                  btnText: "Takas Edilecekler",
                  btnHeight: 30,
                  btnColor: const Color.fromARGB(255, 232, 187, 119),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
