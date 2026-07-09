import 'package:hive/hive.dart';

part 'book_model.g.dart';

@HiveType(typeId: 0)
class BookModel extends HiveObject {
  @HiveField(0)
  final String bookName;
  @HiveField(1)
  final int bookID;
  @HiveField(2)
  final int chapterCount;
  BookModel({
    required this.bookID,
    required this.bookName,
    required this.chapterCount,
  });
}
