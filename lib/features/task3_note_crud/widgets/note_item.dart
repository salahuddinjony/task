import 'package:flutter/material.dart';
import '../../../data/models/note/note.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSync;
  const NoteItem({
    Key? key,
    required this.note,
    required this.onEdit,
    required this.onDelete,
    required this.onSync,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(note.color),
        ),
        title: Text(note.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(note.content, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              note.isSynced ? Icons.cloud_done : Icons.cloud_off,
              color: note.isSynced ? Colors.green : Colors.red,
              size: 20,
            ),
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: onSync,
              tooltip: 'Sync',
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
              tooltip: 'Edit',
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
              tooltip: 'Delete',
            ),
          ],
        ),
      ),
    );
  }
} 