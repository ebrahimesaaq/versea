import 'package:versea/utils/data_source/local_data_source/bible_book_model.dart';
import 'package:versea/utils/data_source/local_data_source/book_code.dart';

class LoadBooks {
  void loadBooks({
    required List<BibleBookModel> oldBooks,
    required List<BibleBookModel> newBooks,
    required setState,
  }) {
    oldBooks.addAll(bibleBooks.take(39));
    newBooks.addAll(bibleBooks.skip(39));

    setState();
  }
}
