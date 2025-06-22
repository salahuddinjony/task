import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/note.dart';
import '../../controllers/note_controller.dart';

class NoteEditController extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final RxInt selectedColor = Colors.amber.value.obs;

  void setNote(Note? note) {
    if (note != null) {
      titleController.text = note.title;
      contentController.text = note.content;
      selectedColor.value = note.color;
    } else {
      titleController.clear();
      contentController.clear();
      selectedColor.value = Colors.amber.value;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }
}

class NoteEditScreen extends StatelessWidget {
  final Note? note;
  final NoteEditController editController = Get.put(NoteEditController());
  NoteEditScreen({Key? key, this.note}) : super(key: key) {
    editController.setNote(note);
  }

  final List<Color> colors = [
    Colors.amber,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.orange,
    Colors.brown,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    final noteController = Get.find<NoteController>();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: Text(note == null ? 'Add Note' : 'Edit Note')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: editController.titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Title required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: editController.contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 5,
                validator: (v) => v == null || v.trim().isEmpty ? 'Content required' : null,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: colors.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final color = colors[i];
                    return Obx(() => GestureDetector(
                          onTap: () => editController.selectedColor.value = color.value,
                          child: CircleAvatar(
                            backgroundColor: color,
                            child: editController.selectedColor.value == color.value
                                ? const Icon(Icons.check, color: Colors.white)
                                : null,
                          ),
                        ));
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final isEdit = note != null;
                      final newNote = Note(
                        id: isEdit ? note!.id : DateTime.now().millisecondsSinceEpoch,
                        title: editController.titleController.text.trim(),
                        content: editController.contentController.text.trim(),
                        color: editController.selectedColor.value,
                        isSynced: false,
                      );
                      if (isEdit) {
                        await noteController.updateNote(newNote);
                      } else {
                        await noteController.addNote(newNote);
                      }
                      Get.back();
                      noteController.fetchNotes();
                    }
                  },
                  child: Text(note == null ? 'Add Note' : 'Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 