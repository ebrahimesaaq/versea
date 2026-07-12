class BibleBookModel {
  final int id;
  final String code;
  final String name;
  final int chapters;

  const BibleBookModel({
    required this.code,
    required this.name,
    required this.chapters,
    required this.id,
  });
}
