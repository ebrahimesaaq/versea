import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:versea/main.dart';
import 'package:versea/services/connectivity_checker.dart';

class SyncServices {
  ConnectionChecker connectionChecker = ConnectionChecker();
  Future<void> sync() async {
    final connected = await connectionChecker.check();

    if (connected) {
      final user = FirebaseAuth.instance.currentUser!.uid;

      final remote = await getLastReadingFromFirebase();
      final local = getLocalLastRead();

      final remoteNew = remote['new'];
      final remoteOld = remote['old'];

      final localNew = local['new'];
      final localOld = local['old'];

      // =========================
      // New Testament
      // =========================

      if (remoteNew != null && localNew['time'] != null) {
        await newTestSync(user, localNew, remoteNew);
      } else if (remoteNew == null && localNew['time'] != null) {
        await FirebaseFirestore.instance
            .collection('last_read')
            .doc(user)
            .collection('last_read')
            .doc('new_testament')
            .set({
              'book_name': localNew['book_name'],
              'time': localNew['time'],
              'book_id': int.parse(localNew['book_id']),
              'chapter': int.parse(localNew['chapter']),
              'chapter_count': int.parse(localNew['chapter_count']),
            });
      } else if (remoteNew != null && localNew['time'] == null) {
        await prefs?.setInt('newBookID', int.parse(remoteNew['book_id']));
        await prefs?.setString('newBookName', remoteNew['book_name']);
        await prefs?.setInt('newChapter', int.parse(remoteNew['chapter']));
        await prefs?.setInt(
          'newChapterCount',
          int.parse(remoteNew['chapter_count']),
        );
        await prefs?.setString('newTime', remoteNew['time']);
      }

      // =========================
      // Old Testament
      // =========================

      if (remoteOld != null && localOld['time'] != null) {
        await oldTestSync(user, localOld, remoteOld);
      } else if (remoteOld == null && localOld['time'] != null) {
        await FirebaseFirestore.instance
            .collection('last_read')
            .doc(user)
            .collection('last_read')
            .doc('old_testament')
            .set({
              'book_name': localOld['book_name'],
              'time': localOld['time'],
              'book_id': localOld['book_id'],
              'chapter': localOld['chapter'],
              'chapter_count': localOld['chapter_count'],
            });
      } else if (remoteOld != null && localOld['time'] == null) {
        await prefs?.setInt('oldBookID', int.parse(remoteOld['book_id']));
        await prefs?.setString('oldBookName', remoteOld['book_name']);
        await prefs?.setInt('oldChapter', int.parse(remoteOld['chapter']));
        await prefs?.setInt(
          'oldChapterCount',
          int.parse(remoteOld['chapter_count']),
        );
        await prefs?.setString('oldTime', remoteOld['time']);
      }
    }
  }
}

Future<Map<String, dynamic>> getLastReadingFromFirebase() async {
  final user = FirebaseAuth.instance.currentUser!.uid;
  final newTestResponse = await FirebaseFirestore.instance
      .collection('last_read')
      .doc(user)
      .collection('last_read')
      .doc('new_testament')
      .get();
  final oldTestResponse = await FirebaseFirestore.instance
      .collection('last_read')
      .doc(user)
      .collection('last_read')
      .doc('old_testament')
      .get();
  final oldTest = oldTestResponse.data();
  final newTest = newTestResponse.data();
  Map<String, dynamic> lastRead = {'new': newTest, 'old': oldTest};
  return lastRead;
}

Map<String, dynamic> getLocalLastRead() {
  Map<String, dynamic> oldTest = {
    'book_id': prefs?.getInt('oldBookID'),
    'book_name': prefs?.getString('oldBookName'),
    'chapter': prefs?.getInt('oldChapter'),
    'chapter_count': prefs?.getInt('oldChapterCount'),
    'time': prefs?.getString('oldTime'),
  };
  Map<String, dynamic> newTest = {
    'book_id': prefs?.getInt('newBookID'),
    'book_name': prefs?.getString('newBookName'),
    'chapter': prefs?.getInt('newChapter'),
    'chapter_count': prefs?.getInt('newChapterCount'),
    'time': prefs?.getString('newTime'),
  };

  Map<String, dynamic> lastRead = {'new': newTest, 'old': oldTest};
  return lastRead;
}

String compareTime(String local, String remote) {
  final timeLocal = DateTime.parse(local);
  final timeRemote = DateTime.parse(remote);
  if (timeRemote.isAfter(timeLocal)) {
    return 'remote';
  } else if (timeRemote.isBefore(timeLocal)) {
    return 'local';
  }
  return 'same';
}

Future<void> newTestSync(
  String user,
  Map<String, dynamic> localLastRead,
  Map<String, dynamic> remoteLastRead,
) async {
  final comparingResult = compareTime(
    localLastRead['time'],
    remoteLastRead['time'],
  );

  if (comparingResult == 'remote') {
    await prefs?.setInt('newBookID', int.parse(remoteLastRead['book_id']));
    await prefs?.setString('newBookName', remoteLastRead['book_name']);
    await prefs?.setInt('newChapter', int.parse(remoteLastRead['chapter']));
    await prefs?.setInt(
      'newChapterCount',
      int.parse(remoteLastRead['chapter_count']),
    );
    await prefs?.setString('newTime', remoteLastRead['time']);
  } else if (comparingResult == 'local') {
    await FirebaseFirestore.instance
        .collection('last_read')
        .doc(user)
        .collection('last_read')
        .doc('new_testament')
        .set({
          'book_name': localLastRead['book_name'],
          'time': localLastRead['time'],
          'book_id': localLastRead['book_id'],
          'chapter': localLastRead['chapter'],
          'chapter_count': localLastRead['chapter_count'],
        });
  }
}

Future<void> oldTestSync(
  String user,
  Map<String, dynamic> localLastRead,
  Map<String, dynamic> remoteLastRead,
) async {
  final comparingResult = compareTime(
    localLastRead['time'],
    remoteLastRead['time'],
  );

  if (comparingResult == 'remote') {
    await prefs?.setInt('oldBookID', remoteLastRead['book_id']);
    await prefs?.setString('oldBookName', remoteLastRead['book_name']);
    await prefs?.setInt('oldChapter', remoteLastRead['chapter']);
    await prefs?.setInt('oldChapterCount', remoteLastRead['chapter_count']);
    await prefs?.setString('oldTime', remoteLastRead['time']);
  } else if (comparingResult == 'local') {
    await FirebaseFirestore.instance
        .collection('last_read')
        .doc(user)
        .collection('last_read')
        .doc('old_testament')
        .set({
          'book_name': localLastRead['book_name'],
          'time': localLastRead['time'],
          'book_id': localLastRead['book_id'],
          'chapter': localLastRead['chapter'],
          'chapter_count': localLastRead['chapter_count'],
        });
  }
}
