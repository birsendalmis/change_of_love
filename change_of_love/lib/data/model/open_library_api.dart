import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> searchBooks(String query) async {
  final response =
      await http.get(Uri.parse('https://openlibrary.org/search.json?q=$query'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> docs = data['docs'];
    return docs;
  } else {
    throw Exception('Failed to load search results');
  }
}
