import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/note/note_model.dart';

class NoteRemoteDataSource {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<bool> syncNote(NoteModel note) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': note.id,
          'title': note.title,
          'body': note.content,
          'color': note.color,
        }),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
} 