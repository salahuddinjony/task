import 'package:hive/hive.dart';
import '../../domain/entities/note.dart';
part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String content;
  @HiveField(3)
  int color;
  @HiveField(4)
  bool isSynced;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.isSynced,
  });

  factory NoteModel.fromEntity(Note note) => NoteModel(
        id: note.id,
        title: note.title,
        content: note.content,
        color: note.color,
        isSynced: note.isSynced,
      );

  Note toEntity() => Note(
        id: id,
        title: title,
        content: content,
        color: color,
        isSynced: isSynced,
      );
} 