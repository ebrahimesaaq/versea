import 'package:flutter/material.dart';
import 'package:versea/Features/Home/presentation/Widgets/buttons.dart';
import 'package:versea/Features/Home/presentation/Widgets/verse.dart';
import 'package:versea/utils/Core/assets.dart';

class VerseOfTheDayCategory extends StatefulWidget {
  const VerseOfTheDayCategory({super.key});

  @override
  State<VerseOfTheDayCategory> createState() => _VerseOfTheDayCategoryState();
}

class _VerseOfTheDayCategoryState extends State<VerseOfTheDayCategory> {
  @override
  Widget build(BuildContext context) {
    bool theme = Theme.of(context).brightness == Brightness.dark;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 18),
      width: double.infinity,
      height: height * 0.32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme ? Colors.grey[300] : Colors.cyanAccent,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Image.asset(
                theme ? Assets.darkVOD : Assets.lightVOD,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Verse(),
              SizedBox(height: 17),
              Buttons(),
            ],
          ),
        ],
      ),
    );
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
