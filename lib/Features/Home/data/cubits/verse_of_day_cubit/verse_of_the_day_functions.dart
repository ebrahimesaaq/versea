import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:versea/main.dart';
import 'package:versea/utils/data_source/local_data_source/book_code.dart';

Future<String> getVerseOfTheDay() async {
  final response = await http.get(
    Uri.parse('https://beta.ourmanna.com/api/v1/get'),
  );

  if (response.statusCode == 200) {
    return response.body;
  }

  throw Exception('Failed');
}

Future<Map<String, dynamic>> getRef() async {
  try {
    final verse = await getVerseOfTheDay();

    String bookName = '';
    String verseText = '';
    int chapterID = 0;
    int verseID = 0;

    final reference = RegExp(r'-\s(.+?)\s\(').firstMatch(verse)!.group(1);

    final finalRef2 = RegExp(r'(.+)\s(\d+):(\d+)').firstMatch(reference!);

    if (finalRef2 != null) {
      bookName = finalRef2.group(1)!;
      chapterID = int.parse(finalRef2.group(2)!);
      verseID = int.parse(finalRef2.group(3)!);
    }

    int getBookNumber() {
      return bookNameToId[bookName]!;
    }

    final book = bibleBooks[getBookNumber() - 1];

    final jsonString = await rootBundle.loadString(
      'assets/bible/arb_vdv/${book.code}/$chapterID.json',
    );

    final data = json.decode(jsonString);

    final versea = (data['chapter']['content'] as List).firstWhere(
      (e) => e['type'] == 'verse' && e['number'] == verseID,
    );

    verseText = versea['content'][0];
    bookName = book.name;

    final myVerse = [
      bookName,
      chapterID.toString(),
      verseID.toString(),
      verseText,
    ];

    final today = DateTime.now().toIso8601String().split('T')[0];

    final savedDate = prefs!.getString('verseDate');

    if (savedDate != today) {
      await prefs!.setString('verseDate', today);
      await prefs!.setStringList('verseOfTheDay', myVerse);
    }

    return {
      'bookName': myVerse[0],
      'chapterID': myVerse[1],
      'verseID': myVerse[2],
      'text': myVerse[3],
    };
  } catch (e) {
    final savedVerse = prefs!.getStringList('verseOfTheDay');

    if (savedVerse != null && savedVerse.length >= 4) {
      return {
        'bookName': savedVerse[0],
        'chapterID': savedVerse[1],
        'verseID': savedVerse[2],
        'text': savedVerse[3],
      };
    }
    return {
      'bookName': 'يوحنا',
      'chapterID': '3',
      'verseID': '16',
      'text':
          'لأَنَّهُ هكَذَا أَحَبَّ اللهُ الْعَالَمَ حَتَّى بَذَلَ ابْنَهُ الْوَحِيدَ، لِكَيْ لاَ يَهْلِكَ كُلُّ مَنْ يُؤْمِنُ بِهِ، بَلْ تَكُونُ لَهُ الْحَيَاةُ الأَبَدِيَّةُ.',
    };
  }
}

const Map<String, int> bookNameToId = {
  "Genesis": 1,
  "Exodus": 2,
  "Leviticus": 3,
  "Numbers": 4,
  "Deuteronomy": 5,
  "Joshua": 6,
  "Judges": 7,
  "Ruth": 8,
  "1 Samuel": 9,
  "2 Samuel": 10,
  "1 Kings": 11,
  "2 Kings": 12,
  "1 Chronicles": 13,
  "2 Chronicles": 14,
  "Ezra": 15,
  "Nehemiah": 16,
  "Esther": 17,
  "Job": 18,
  "Psalm": 19,
  "Proverbs": 20,
  "Ecclesiastes": 21,
  "Song of Solomon": 22,
  "Isaiah": 23,
  "Jeremiah": 24,
  "Lamentations": 25,
  "Ezekiel": 26,
  "Daniel": 26,
  "Hosea": 28,
  "Joel": 29,
  "Amos": 30,
  "Obadiah": 31,
  "Jonah": 23,
  "Micah": 33,
  "Nahum": 34,
  "Habakkuk": 35,
  "Zephaniah": 36,
  "Haggai": 37,
  "Zechariah": 38,
  "Malachi": 39,
  "Matthew": 40,
  "Mark": 41,
  "Luke": 42,
  "John": 43,
  "Acts": 44,
  "Romans": 45,
  "1 Corinthians": 46,
  "2 Corinthians": 47,
  "Galatians": 48,
  "Ephesians": 49,
  "Philippians": 50,
  "Colossians": 51,
  "1 Thessalonians": 52,
  "2 Thessalonians": 53,
  "1 Timothy": 54,
  "2 Timothy": 55,
  "Titus": 56,
  "Philemon": 57,
  "Hebrews": 58,
  "James": 59,
  "1 Peter": 60,
  "2 Peter": 61,
  "1 John": 62,
  "2 John": 63,
  "3 John": 64,
  "Jude": 65,
  "Revelation": 66,
};
