import 'package:get/get.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecases/get_notes_usecase.dart';
import '../../domain/usecases/add_note_usecase.dart';
import '../../domain/usecases/update_note_usecase.dart';
import '../../domain/usecases/delete_note_usecase.dart';
import '../../domain/usecases/sync_note_usecase.dart';

class NoteController extends GetxController {
  final GetNotesUseCase getNotesUseCase;
  final AddNoteUseCase addNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final SyncNoteUseCase syncNoteUseCase;

  NoteController({
    required this.getNotesUseCase,
    required this.addNoteUseCase,
    required this.updateNoteUseCase,
    required this.deleteNoteUseCase,
    required this.syncNoteUseCase,
  });

  var notes = <Note>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    try {
      isLoading.value = true;
      error.value = '';
      notes.value = await getNotesUseCase();
    } catch (e) {
      print('Error loading notes: $e');
      error.value = 'Failed to load notes';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addNote(Note note) async {
    try {
      await addNoteUseCase(note);
      notes.add(note);
    } catch (e) {
      error.value = 'Failed to add note';
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await updateNoteUseCase(note);
      int idx = notes.indexWhere((n) => n.id == note.id);
      if (idx != -1) notes[idx] = note;
    } catch (e) {
      error.value = 'Failed to update note';
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await deleteNoteUseCase(id);
      notes.removeWhere((n) => n.id == id);
    } catch (e) {
      error.value = 'Failed to delete note';
    }
  }

  Future<void> syncNote(Note note) async {
    try {
      final success = await syncNoteUseCase(note);
      if (success) {
        int idx = notes.indexWhere((n) => n.id == note.id);
        if (idx != -1) notes[idx] = Note(
          id: note.id,
          title: note.title,
          content: note.content,
          color: note.color,
          isSynced: true,
        );
      }
    } catch (e) {
      error.value = 'Failed to sync note';
    }
  }

  Future<void> retryUnsyncedNotes() async {
    for (final note in notes.where((n) => !n.isSynced)) {
      await syncNote(note);
    }
  }
} 