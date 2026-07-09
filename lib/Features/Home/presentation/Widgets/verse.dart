import 'package:flutter/material.dart';
import 'package:versea/Features/Home/presentation/Widgets/get_verse_of_the_day.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/utils/Core/app_colors.dart';

class Verse extends StatefulWidget {
  const Verse({super.key});

  @override
  State<Verse> createState() => _VerseState();
}

class _VerseState extends State<Verse> {
  late Map verseOfDay = {
    // 'bookName': 'فيلبي',
    // 'chapterID': 13,
    // 'verseID': 4,
    // 'text': 'أَسْتَطِيعُ كُلَّ شَيْءٍ فِي الْمَسِيحِ الَّذِي يُقَوِّينِي',
    'bookName': '',
    'chapterID': '',
    'verseID': '',
    'text': '',
  };

  @override
  void initState() {
    super.initState();
    loadVerse();
  }

  Future<void> loadVerse() async {
    verseOfDay = await GetVerseOfTheDay().getRef();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          S.of(context).verseOfTheDay,
          style: TextStyle(color: LightAppColors.secondaryColor, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12),
        Text(
          verseOfDay['text'],
          style: TextStyle(
            backgroundColor:
                (!isDark
                        ? DarkAppColors2.tertiaryColor
                        : DarkAppColors2.neutralColor)
                    .withValues(alpha: 0.5),
            fontSize: 22,

            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: isDark
                ? DarkAppColors2.tertiaryColor
                : DarkAppColors2.neutralColor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12),
        Text(
          '${verseOfDay['bookName']} ${verseOfDay['verseID']}:${verseOfDay['chapterID']}',

          style: TextStyle(
            backgroundColor:
                (!isDark
                        ? DarkAppColors2.tertiaryColor
                        : DarkAppColors2.neutralColor)
                    .withValues(alpha: 0.5),
            fontSize: 16,

            color: isDark
                ? DarkAppColors2.tertiaryColor
                : DarkAppColors2.neutralColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
