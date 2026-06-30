import 'section.dart';

class ChapterModel {
  String? bookName;
  String? bookId;
  String? chapter;
  int? versesCount;
  List<Section>? sections;
  List<String>? arr;

  ChapterModel({
    this.bookName,
    this.bookId,
    this.chapter,
    this.versesCount,
    this.sections,
    this.arr,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) => ChapterModel(
    bookName: json['bookName'] as String?,
    bookId: json['bookID'] as String?,
    chapter: json['chapter'] as String?,
    versesCount: json['verses_count'] as int?,
    sections: (json['sections'] as List<dynamic>?)
        ?.map((e) => Section.fromJson(e as Map<String, dynamic>))
        .toList(),
    arr: json['arr'] as List<String>?,
  );

  Map<String, dynamic> toJson() => {
    'bookName': bookName,
    'bookID': bookId,
    'chapter': chapter,
    'verses_count': versesCount,
    'sections': sections?.map((e) => e.toJson()).toList(),
    'arr': arr,
  };
}
