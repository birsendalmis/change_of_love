import 'dart:convert';
import 'package:change_of_love/screens/search/books_details.dart';
import 'package:change_of_love/widgets/custom_search.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class BookSearchPage extends StatefulWidget {
  const BookSearchPage({super.key});

  @override
  State<BookSearchPage> createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  final TextEditingController _searchController =
      TextEditingController(); //arama kutusundaki metni kontrol etmek için kullanılır
  List<dynamic> _searchResults =
      []; // arama sonuçlarını depolamak için bir liste. Bu liste, arama sonuçlarını içeren kitapların özelliklerini tutar.

  Future<void> _performSearch(String query) async {
    //query parametresi, kullanıcının arama kutusuna girdiği metni temsil eder
    //fonksiyonu, kullanıcının arama yapmasını sağlar. Boş bir sorgu yapıldığında, _searchResults listesini temizler ve yeni bir arama yapmaz. Aksi takdirde, Google Kitaplar API'sine yapılan bir HTTP GET isteği ile arama yapılır ve sonuçlar işlenir.
    if (query.isEmpty) {
      //if (query.isEmpty) ifadesi, eğer kullanıcı bir şey girmediyse veya mevcut sorguyu temizlediyse yapılacakları belirler.
      // Boş bir sorgu yapılmışsa, arama sonuçlarını temizle
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    final response = await http.get(
      Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _searchResults = data['items'] ?? [];
      });
    } else {
      throw Exception('Arama sonuçları yüklenemedi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          CustomSearchBar(
            controller: _searchController,
            onChanged: (value) {
              _performSearch(value);
            },
            onSubmitted: (value) {
              _performSearch(value);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final volumeInfo = _searchResults[index]['volumeInfo'];
                final thumbnailUrl = volumeInfo['imageLinks']?['thumbnail'];
                final title = volumeInfo['title'] ?? '-';
                final authors = volumeInfo['authors'] != null
                    ? volumeInfo['authors'].join(', ')
                    : '-';
                // print('Thumbnail URL: $thumbnailUrl');

                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsPage(
                          volumeInfo: volumeInfo,
                        ),
                      ),
                    );
                  },
                  leading: thumbnailUrl != null
                      ? Image.network(
                          thumbnailUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.camera_alt),
                  title: Text(title),
                  subtitle: Text(authors),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
