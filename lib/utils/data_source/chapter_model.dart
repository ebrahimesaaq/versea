import 'package:hive_flutter/adapters.dart';

part 'chapter_model.g.dart';

@HiveType(typeId: 1)
class ChapterModel extends HiveObject {
  @HiveField(0)
  final String bookName;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final int bookID;
  @HiveField(3)
  final int chapterID;
  @HiveField(4)
  final int verses;
  ChapterModel({
    required this.bookName,
    required this.text,
    required this.bookID,
    required this.chapterID,
    required this.verses,
  });
}
