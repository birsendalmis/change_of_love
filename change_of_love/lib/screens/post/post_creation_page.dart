/*import 'dart:io';

import 'package:flutter/material.dart';

class PostCreationPage extends StatefulWidget {
  @override
  _PostCreationPageState createState() => _PostCreationPageState();
}

class _PostCreationPageState extends State<PostCreationPage> {
  TextEditingController _captionController = TextEditingController();
  String _selectedImage = ''; // Seçilen fotoğrafın yolunu tutar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gönderi Oluştur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Fotoğraf Seçme Düğmesi
            ElevatedButton(
              onPressed: () {
                // TODO: Fotoğraf seçme işlemi
              },
              child: Text('Fotoğraf Seç'),
            ),
            SizedBox(height: 16.0),
            // Seçilen Fotoğrafın Görüntüsü
            _selectedImage.isNotEmpty
                ? Image.file(
                    File(_selectedImage),
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Container(),
            SizedBox(height: 16.0),
            // Açıklama Metni Giriş Alanı
            TextField(
              controller: _captionController,
              decoration: InputDecoration(
                hintText: 'Açıklama',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16.0),
            // Konum Seçme Düğmesi (İsteğe Bağlı)
            ElevatedButton(
              onPressed: () {
                // TODO: Konum seçme işlemi
              },
              child: Text('Konum Seç (İsteğe Bağlı)'),
            ),
            SizedBox(height: 16.0),
            // Gönderi Oluşturma Düğmesi
            ElevatedButton(
              onPressed: () {
                // TODO: Gönderi oluşturma işlemi
              },
              child: Text('Gönder'),
            ),
          ],
        ),
      ),
    );
  }
}
*/