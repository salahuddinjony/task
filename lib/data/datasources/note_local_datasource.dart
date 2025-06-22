import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note/note_model.dart';

class NoteLocalDataSource {
  static const String notesKey = 'notes';

  Future<List<NoteModel>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getStringList(notesKey) ?? [];
    final List<NoteModel> notes = [];
    for (final e in notesJson) {
      try {
        notes.add(NoteModel.fromJson(jsonDecode(e)));
      } catch (err) {
        print('Skipping invalid note: $err');
      }
    }
    return notes;
  }

  Future<void> addNote(NoteModel note) async {
    final prefs = await SharedPreferences.getInstance();
    final notes = await getNotes();
    notes.add(note);
    await prefs.setStringList(notesKey, notes.map((n) => jsonEncode(n.toJson())).toList());
  }

  Future<void> updateNote(NoteModel note) async {
    final prefs = await SharedPreferences.getInstance();
    final notes = await getNotes();
    final idx = notes.indexWhere((n) => n.id == note.id);
    if (idx != -1) notes[idx] = note;
    await prefs.setStringList(notesKey, notes.map((n) => jsonEncode(n.toJson())).toList());
  }

  Future<void> deleteNote(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final notes = await getNotes();
    notes.removeWhere((n) => n.id == id);
    await prefs.setStringList(notesKey, notes.map((n) => jsonEncode(n.toJson())).toList());
  }

  Future<void> saveAllNotes(List<NoteModel> notes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(notesKey, notes.map((n) => jsonEncode(n.toJson())).toList());
  }
} 