import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_local_datasource.dart';
import '../datasources/note_remote_datasource.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource local;
  final NoteRemoteDataSource remote;
  NoteRepositoryImpl({required this.local, required this.remote});

  @override
  Future<List<Note>> getNotes() async {
    final models = await local.getNotes();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> addNote(Note note) async {
    await local.addNote(NoteModel.fromEntity(note));
  }

  @override
  Future<void> updateNote(Note note) async {
    await local.updateNote(NoteModel.fromEntity(note));
  }

  @override
  Future<void> deleteNote(int id) async {
    await local.deleteNote(id);
  }

  @override
  Future<bool> syncNote(Note note) async {
    final model = NoteModel.fromEntity(note);
    final success = await remote.syncNote(model);
    if (success) {
      await local.updateNote(
        NoteModel(
          id: model.id,
          title: model.title,
          content: model.content,
          color: model.color,
          isSynced: true,
        ),
      );
    }
    return success;
  }
} 