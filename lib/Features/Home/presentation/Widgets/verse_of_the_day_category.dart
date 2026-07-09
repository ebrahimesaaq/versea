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
  "Esther": 19,
  "Job": 21,
  "Psalm": 22,
  "Proverbs": 24,
  "Ecclesiastes": 25,
  "Song of Solomon": 26,
  "Isaiah": 29,
  "Jeremiah": 30,
  "Lamentations": 31,
  "Ezekiel": 33,
  "Daniel": 34,
  "Hosea": 36,
  "Joel": 37,
  "Amos": 38,
  "Obadiah": 39,
  "Jonah": 40,
  "Micah": 41,
  "Nahum": 42,
  "Habakkuk": 43,
  "Zephaniah": 44,
  "Haggai": 45,
  "Zechariah": 46,
  "Malachi": 47,
  "Matthew": 50,
  "Mark": 51,
  "Luke": 52,
  "John": 53,
  "Acts": 54,
  "Romans": 55,
  "1 Corinthians": 56,
  "2 Corinthians": 57,
  "Galatians": 58,
  "Ephesians": 59,
  "Philippians": 60,
  "Colossians": 61,
  "1 Thessalonians": 62,
  "2 Thessalonians": 63,
  "1 Timothy": 64,
  "2 Timothy": 65,
  "Titus": 66,
  "Philemon": 67,
  "Hebrews": 68,
  "James": 69,
  "1 Peter": 70,
  "2 Peter": 71,
  "1 John": 72,
  "2 John": 73,
  "3 John": 74,
  "Jude": 75,
  "Revelation": 76,
};
