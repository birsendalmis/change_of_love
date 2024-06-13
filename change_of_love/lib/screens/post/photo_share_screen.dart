/*import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoShareScreen extends StatefulWidget {
  @override
  _PhotoShareScreenState createState() => _PhotoShareScreenState();
}

class _PhotoShareScreenState extends State<PhotoShareScreen> {
  final ImagePicker _picker = ImagePicker();
  late XFile? _image;
  final TextEditingController _captionController = TextEditingController();

  Future<void> _getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void _share() {
    final String? caption = _captionController.text;
    if (_image != null && caption != null && caption.isNotEmpty) {
      print('Image Path: ${_image!.path}');
      print('Caption: $caption');
      // Firestore'a gönderme işlemi burada gerçekleştirilecek.
    } else {
      print('Please select an image and enter a caption.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Share'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_image != null)
              Image.file(
                File(_image!.path),
                height: 200,
                fit: BoxFit.cover,
              ),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _captionController,
              decoration: InputDecoration(
                labelText: 'Caption',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _share,
              child: Text('Share'),
            ),
          ],
        ),
      ),
    );
  }
}
*/