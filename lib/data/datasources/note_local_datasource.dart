import 'package:hive/hive.dart';
import '../models/note_model.dart';

class NoteLocalDataSource {
  static const String boxName = 'notes';

  Future<Box<NoteModel>> _openBox() async {
    return await Hive.openBox<NoteModel>(boxName);
  }

  Future<List<NoteModel>> getNotes() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> addNote(NoteModel note) async {
    final box = await _openBox();
    await box.put(note.id, note);
  }

  Future<void> updateNote(NoteModel note) async {
    final box = await _openBox();
    await box.put(note.id, note);
  }

  Future<void> deleteNote(int id) async {
    final box = await _openBox();
    await box.delete(id);
  }

  Future<void> saveAllNotes(List<NoteModel> notes) async {
    final box = await _openBox();
    final Map<int, NoteModel> map = {for (var n in notes) n.id: n};
    await box.putAll(map);
  }
} 