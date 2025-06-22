import '../../../data/models/note/note.dart';
import '../../../data/models/note/note_repository.dart';
 
class SyncNoteUseCase {
  final NoteRepository repository;
  SyncNoteUseCase(this.repository);
  Future<bool> call(Note note) async => repository.syncNote(note);
} 