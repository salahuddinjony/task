import '../../../data/models/note/note.dart';
import '../../../data/models/note/note_repository.dart';
 
class UpdateNoteUseCase {
  final NoteRepository repository;
  UpdateNoteUseCase(this.repository);
  Future<void> call(Note note) async => repository.updateNote(note);
} 