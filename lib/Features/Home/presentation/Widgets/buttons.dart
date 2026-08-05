import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:versea/Features/Home/data/cubits/verse_of_day_cubit/verse_of_day_cubit.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/main.dart';
import 'package:versea/utils/Core/app_colors.dart';
import 'package:versea/utils/routes/consts.dart';

class Buttons extends StatefulWidget {
  const Buttons({super.key});

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  List<String> savedVerses = [];
  List<String> savedChapterIDs = [];
  List<String> savedVerseIDs = [];
  List<String> savedBookNames = [];

  Map verseOfTheDay = {};
  @override
  void initState() {
    loadVerse();

    super.initState();
  }

  Future loadVerse() async {
    savedVerses = prefs?.getStringList(kSavedVerses) ?? [];
    savedChapterIDs = prefs?.getStringList(kSavedChapterIDs) ?? [];
    savedVerseIDs = prefs?.getStringList(kSavedVerseIDs) ?? [];
    savedBookNames = prefs?.getStringList(kSavedBookNames) ?? [];
    verseOfTheDay = await VerseOfDayCubit().verseOfTheDay();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(),
        TextButton(
          onPressed: () async {
            if (verseOfTheDay['text'] == null) return;

            await SharePlus.instance.share(
              ShareParams(
                title: 'To day`s verse',
                text:
                    '${verseOfTheDay['text']}\n ${verseOfTheDay['bookName']} ${verseOfTheDay['verseID']}:${verseOfTheDay['chapterID']}',
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.amber[50],

              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.share_outlined, size: 17, color: Colors.black),
                SizedBox(width: 7),
                Text(
                  S.of(context).share,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (!savedVerses.contains(verseOfTheDay['text'])) {
              savedVerses.add(verseOfTheDay['text']);
              savedBookNames.add(verseOfTheDay['bookName']);
              savedChapterIDs.add(verseOfTheDay['chapterID']);
              savedVerseIDs.add(verseOfTheDay['verseID']);
              await prefs?.setStringList(kSavedVerses, savedVerses);
              await prefs?.setStringList(kSavedBookNames, savedBookNames);
              await prefs?.setStringList(kSavedChapterIDs, savedChapterIDs);
              await prefs?.setStringList(kSavedVerseIDs, savedVerseIDs);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  width: 150,
                  content: Text('تم حفظ الآية بنجاح'),
                ),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: DarkAppColors.secondaryColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.bookmark_border_outlined,
                  size: 17,
                  color: LightAppColors.secondaryColor,
                ),
                SizedBox(width: 7),

                Text(
                  S.of(context).save,
                  style: TextStyle(
                    fontSize: 16,
                    color: LightAppColors.secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(),
      ],
    );
  }
}
