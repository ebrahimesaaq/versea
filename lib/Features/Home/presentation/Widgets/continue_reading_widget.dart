import 'package:flutter/widgets.dart';
import 'package:versea/Features/Home/presentation/Widgets/continue_reading_card.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/main.dart';

class ContinueReadingWidget extends StatelessWidget {
  const ContinueReadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).continueReading,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),

        prefs!.getInt('oldBookID') == null
            ? SizedBox()
            : ContinueReadingCard(
                bookID: prefs?.getInt('oldBookID') ?? 1,
                chapterCount: prefs?.getInt('oldChapterCount') ?? 0,
                chapterID: prefs?.getInt('oldChapter') ?? 0,
                bookName: prefs?.getString('oldBookName') ?? 'سفر التكوين',
                isOldTestament: true,
                progress:
                    (((prefs?.getInt('oldChapter') ?? 0) /
                                (prefs?.getInt('oldChapterCount') ?? 1))
                            .clamp(0, 1))
                        .toDouble(),
              ),
        prefs!.getInt('newBookID') == null
            ? SizedBox()
            : ContinueReadingCard(
                bookID: prefs?.getInt('newBookID') ?? 50,
                chapterCount: prefs?.getInt('newChapterCount') ?? 0,
                chapterID: prefs?.getInt('newChapter') ?? 0,
                bookName: prefs?.getString('newBookName') ?? 'انجيل متى',
                isOldTestament: false,
                progress:
                    (((prefs?.getInt('newChapter') ?? 0) /
                                (prefs?.getInt('newChapterCount') ?? 1))
                            .clamp(0, 1))
                        .toDouble(),
              ),
      ],
    );
  }
}
