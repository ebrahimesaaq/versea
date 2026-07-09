import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:versea/Features/Home/presentation/Widgets/verse_of_the_day_category.dart';

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
    final verse = await getVerseOfTheDay();
    String bookName = '';
    String verseText = '';
    int chapterID = 0;
    int verseID = 0;

    final reference = RegExp(
      r'-\s(.+?)\s\(',
    ).firstMatch(verse)!.group(1); //1 Corinthians 16:13

    final finalRef2 = RegExp(r'(.+)\s(\d+):(\d+)').firstMatch(reference!);

    if (finalRef2 != null) {
      bookName = finalRef2.group(1)!;
      chapterID = int.parse(finalRef2.group(2)!);
      verseID = int.parse(finalRef2.group(3)!);
    }

    int getBookNumber() {
      return bookNameToId[bookName]!;
    }

    final response = await http.get(
      Uri.parse(
        'https://arabic-bible.onrender.com/api?book=${getBookNumber()}&ch=$chapterID&ver=$verseID',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      bookName = data['bookName'];

      verseText = data['text'].replaceFirst(RegExp(r'^\d+\s*'), '');
    }
    // throw Exception('failed');

    return {
      'bookName': bookName,
      'chapterID': chapterID,
      'verseID': verseID,
      'text': verseText,
    };
  }
}
