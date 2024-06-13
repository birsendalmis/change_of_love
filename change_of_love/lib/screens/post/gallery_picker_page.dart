import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'next_page.dart';

class GalleryPickerPage extends StatefulWidget {
  @override
  _GalleryPickerPageState createState() => _GalleryPickerPageState();
}

class _GalleryPickerPageState extends State<GalleryPickerPage> {
  XFile? _selectedImage;

  // Fotoğraf seçme işlemini gerçekleştirir
  Future<void> _pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  // "İleri" butonuna basıldığında yeni sayfaya yönlendirme işlemini gerçekleştirir
  void _navigateToNextPage() {
    if (_selectedImage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NextPage(imagePath: _selectedImage!.path)),
      );
    } else {
      // Kullanıcı bir fotoğraf seçmemişse uyarı mesajı göster
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Uyarı'),
          content: Text('Lütfen bir fotoğraf seçiniz.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galeri'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _selectedImage != null
                  ? Image.file(
                      File(_selectedImage!.path),
                      fit: BoxFit.cover,
                    )
                  : Icon(Icons.image, size: 100),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Fotoğraf Seç'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToNextPage,
        tooltip: 'İleri',
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
