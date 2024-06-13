import 'package:flutter/material.dart';
import 'package:change_of_love/data/firebase_services/firestor.dart';

class SearchCustomUserPost extends StatelessWidget {
  final String postId;
  final String userName;
  final String userAssetName;
  final String postAssetName;
  final String postText;

  SearchCustomUserPost({
    required this.postId,
    required this.userName,
    required this.userAssetName,
    required this.postAssetName,
    required this.postText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Üst kısım: Kullanıcı bilgileri (il - ilçe)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<Map<String, dynamic>?>(
              future: FirebaseFirestor().getUserDetails(
                  postId), // Kullanıcının city ve district bilgilerini al
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox
                      .shrink(); // Veri yüklenene kadar hiçbir şey gösterme
                }
                if (snapshot.hasError) {
                  return Text('Hata: ${snapshot.error}');
                }
                Map<String, dynamic>? userDetails = snapshot.data;
                if (userDetails == null || userDetails.isEmpty) {
                  return SizedBox
                      .shrink(); // Kullanıcı bilgisi yoksa hiçbir şey gösterme
                }
                String city = userDetails['city'] ?? '';
                String district = userDetails['district'] ?? '';
                String locationText = '$city - $district';
                return Text(
                  locationText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                );
              },
            ),
          ),
          // Orta kısım: Paylaşılan fotoğraf
          Expanded(
            child: Image.network(
              postAssetName,
              fit: BoxFit.cover,
              height: 150,
            ),
          ),
          // Alt kısım: Kullanıcı adı ve paylaşım metni
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$userName: $postText',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
