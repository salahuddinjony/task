import '../../../data/models/note/note.dart';
import '../../../data/models/note/note_repository.dart';
 
class GetNotesUseCase {
  final NoteRepository repository;
  GetNotesUseCase(this.repository);
  Future<List<Note>> call() async => repository.getNotes();
} 