import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:versea/Features/Home/presentation/Widgets/verse_of_the_day_category.dart';
import 'package:versea/main.dart';
import 'package:versea/utils/data_source/local_data_source/book_code.dart';

class GetVerseOfTheDay {
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
}
