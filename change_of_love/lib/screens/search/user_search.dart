import 'package:change_of_love/data/firebase_services/firestor.dart';
import 'package:flutter/material.dart';

class SearchUsersPage extends StatefulWidget {
  @override
  _SearchUsersPageState createState() => _SearchUsersPageState();
}

class _SearchUsersPageState extends State<SearchUsersPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kullanıcı Ara'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                _performSearch(value);
              },
              decoration: InputDecoration(
                hintText: 'Şehir ara...',
              ),
            ),
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final user = _searchResults[index];
        return ListTile(
          leading: user['profileImage'] != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(user['profileImage']),
                )
              : Icon(Icons.person),
          title: Text(user['username']),
          subtitle: Text(user['city'] ?? 'Şehir bilgisi yok'),
          onTap: () {
            // Kullanıcı profil sayfasına yönlendirme işlemi
            // Burada gerekli navigasyon kodları bulunmalı
          },
        );
      },
    );
  }

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      FirebaseFirestor().searchUsersByCity(query).then((results) {
        setState(() {
          _searchResults = results;
        });
      }).catchError((error) {
        print('Error searching users by city: $error');
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }
}
