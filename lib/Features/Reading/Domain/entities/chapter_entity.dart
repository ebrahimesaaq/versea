import 'package:versea/Features/Reading/Domain/model/chapter_model/chapter_model.dart';

class ChapterEntity extends ChapterModel {
  final String theBookName;
  final String chapterTitle;
  final List<String> verses;

  ChapterEntity({
    required this.chapterTitle,
    required this.verses,
    required this.theBookName,
  }) : super(arr: verses, bookName: theBookName, chapter: chapterTitle);
}
