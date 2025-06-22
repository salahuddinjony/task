import '../../../data/models/note/note.dart';
import '../../../data/models/note/note_repository.dart';
 
class AddNoteUseCase {
  final NoteRepository repository;
  AddNoteUseCase(this.repository);
  Future<void> call(Note note) async => repository.addNote(note);
} 