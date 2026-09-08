import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:versea/main.dart';
import 'package:versea/utils/data_source/local_data_source/book_code.dart';

class InterNetConnectedSaveReadingFunctions {
  Future<void> lastChapter(int bookId, String bookName) async {
    final user = FirebaseAuth.instance.currentUser!.uid;

    final bool isNewTestament = bookId >= 40;

    final String testament = isNewTestament ? 'new_testament' : 'old_testament';

    final String prefix = isNewTestament ? 'new' : 'old';

    final now = DateTime.now().toString();

    await FirebaseFirestore.instance
        .collection('last_read')
        .doc(user)
        .collection('last_read')
        .doc(testament)
        .set({
          'book_name': bibleBooks[bookId].name,
          'time': now,
          'book_id': bookId.toString(),
          'chapter': '1',
          'chapter_count': bibleBooks[bookId].chapters.toString(),
        });

    await prefs?.setBool('${prefix}NewSaved', true);
    await prefs?.setString('${prefix}BookName', bibleBooks[bookId].name);
    await prefs?.setString('${prefix}Time', now);
    await prefs?.setInt('${prefix}BookID', bookId);
    await prefs?.setInt('${prefix}Chapter', 1);
    await prefs?.setInt('${prefix}ChapterCount', bibleBooks[bookId].chapters);
  }

  Future<void> notLastChapter(
    int bookId,
    String bookName,
    int chapterCount,
    int chapterID,
  ) async {
    final bool isNewTestament = bookId >= 40;

    final String prefix = isNewTestament ? 'new' : 'old';

    final now = DateTime.now().toString();

    await prefs?.setBool('${prefix}NewSaved', true);
    await prefs?.setString('${prefix}BookName', bookName);
    await prefs?.setString('${prefix}Time', now);

    // لا نطرح 1 من bookId
    await prefs?.setInt('${prefix}BookID', bookId);

    // chapterID هو الفصل الذي انتهى المستخدم منه
    // لذلك الفصل التالي = chapterID + 1
    await prefs?.setInt('${prefix}Chapter', chapterID + 1);

    await prefs?.setInt('${prefix}ChapterCount', chapterCount);

    final String testament = isNewTestament ? 'new_testament' : 'old_testament';

    final user = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('last_read')
        .doc(user)
        .collection('last_read')
        .doc(testament)
        .set({
          'book_name': bookName,
          'time': now,
          'book_id': bookId.toString(),
          'chapter': (chapterID + 1).toString(),
          'chapter_count': chapterCount.toString(),
        });
  }
}

class InternetDisconnectedSaveReadingFunctions {
  Future<void> lastChapter(int bookId, String bookName) async {
    final bool isNewTestament = bookId >= 40;

    final String prefix = isNewTestament ? 'new' : 'old';

    final now = DateTime.now().toString();

    await prefs?.setBool('${prefix}NewSaved', true);
    await prefs?.setString('${prefix}BookName', bookName);
    await prefs?.setString('${prefix}Time', now);
    await prefs?.setInt('${prefix}BookID', bookId);
    await prefs?.setInt('${prefix}Chapter', 1);
    await prefs?.setInt('${prefix}ChapterCount', bibleBooks[bookId].chapters);
  }

  Future<void> notLastChapter(
    int bookId,
    String bookName,
    int chapterCount,
    int chapterID,
  ) async {
    final bool isNewTestament = bookId >= 40;

    final String prefix = isNewTestament ? 'new' : 'old';

    final now = DateTime.now().toString();

    await prefs?.setBool('${prefix}NewSaved', true);
    await prefs?.setString('${prefix}BookName', bookName);
    await prefs?.setString('${prefix}Time', now);
    await prefs?.setInt('${prefix}BookID', bookId);
    await prefs?.setInt('${prefix}Chapter', chapterID + 1);
    await prefs?.setInt('${prefix}ChapterCount', chapterCount);
  }
}
