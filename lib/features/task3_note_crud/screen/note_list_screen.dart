import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/datasources/note_local_datasource.dart';
import '../../../data/datasources/note_remote_datasource.dart';
import '../../../data/models/repositories/note_repository_impl.dart';
import '../operations/get_notes_usecase.dart';
import '../operations/add_note_usecase.dart';
import '../operations/update_note_usecase.dart';
import '../operations/delete_note_usecase.dart';
import '../operations/sync_note_usecase.dart';
import '../controller/note_controller.dart';
import '../widgets/note_item.dart';
import 'note_edit_screen.dart';

class NoteListScreen extends StatelessWidget {
  NoteListScreen({Key? key}) : super(key: key);
  final NoteController controller = Get.put(
    NoteController(
      getNotesUseCase: GetNotesUseCase(
        NoteRepositoryImpl(
          local: NoteLocalDataSource(),
          remote: NoteRemoteDataSource(),
        ),
      ),
      addNoteUseCase: AddNoteUseCase(
        NoteRepositoryImpl(
          local: NoteLocalDataSource(),
          remote: NoteRemoteDataSource(),
        ),
      ),
      updateNoteUseCase: UpdateNoteUseCase(
        NoteRepositoryImpl(
          local: NoteLocalDataSource(),
          remote: NoteRemoteDataSource(),
        ),
      ),
      deleteNoteUseCase: DeleteNoteUseCase(
        NoteRepositoryImpl(
          local: NoteLocalDataSource(),
          remote: NoteRemoteDataSource(),
        ),
      ),
      syncNoteUseCase: SyncNoteUseCase(
        NoteRepositoryImpl(
          local: NoteLocalDataSource(),
          remote: NoteRemoteDataSource(),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: controller.retryUnsyncedNotes,
            tooltip: 'Sync Unsynced Notes',
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.error.value.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }
        if (controller.notes.isEmpty) {
          return const Center(child: Text('No notes yet.'));
        }
        return ListView.builder(
          itemCount: controller.notes.length,
          itemBuilder: (context, index) {
            final note = controller.notes[index];
            return NoteItem(
              note: note,
              onEdit: () => Get.to(() => NoteEditScreen(note: note)),
              onDelete: () => controller.deleteNote(note.id),
              onSync: () => controller.syncNote(note),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => NoteEditScreen()),
        child: const Icon(Icons.add),
        tooltip: 'Add Note',
      ),
    );
  }
} 