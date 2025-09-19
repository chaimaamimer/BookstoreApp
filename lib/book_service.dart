import 'dart:convert';
import 'package:flutter/services.dart';
import 'bookdetails_page.dart'; // là où ta classe Book est définie

Future<List<Book>> loadBooks() async {
  final String response = await rootBundle.loadString('assets/data/books_data.json');
  final List<dynamic> data = json.decode(response);

  return data.map((bookJson) => Book.fromJson(bookJson)).toList();
}
