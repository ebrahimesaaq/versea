import 'package:flutter/material.dart';
import 'package:versea/Features/Bible/presentation/Widgets/chapters_grid_view_builder.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/utils/Core/assets.dart';
import 'package:versea/utils/data_source/local_data_source/bible_book_model.dart';
import 'package:versea/utils/data_source/local_data_source/book_code.dart';

class ContinueReadingCard extends StatelessWidget {
  final bool isOldTestament;

  final double progress;

  final String bookName;

  final int chapterCount;

  final int chapterID;
  final int bookID;

  const ContinueReadingCard({
    super.key,
    required this.isOldTestament,
    required this.progress,
    required this.bookName,
    required this.chapterCount,
    required this.chapterID,
    required this.bookID,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToReadingScreen(
          context: context,
          book: BibleBookModel(
            code: bibleBooks[bookID].code,
            name: bibleBooks[bookID].name,
            chapters: bibleBooks[bookID].chapters,
            id: bibleBooks[bookID].id,
          ),
          chapterID: chapterID,
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(12),
                child: Image.asset(
                  isOldTestament
                      ? Assets.oldTestamentIcon
                      : Assets.newTestamentIcon,
                  width: 90,
                ),
              ),
              SizedBox(width: 8),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isOldTestament
                          ? S.of(context).oldTestament
                          : S.of(context).newTestament,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    Text(
                      bookName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 12),

                    Row(
                      children: [
                        Text('الإصحاح $chapterID'),
                        Spacer(),
                        Text('من $chapterCount'),
                      ],
                    ),

                    progress == 0
                        ? SizedBox()
                        : LinearProgressIndicator(value: progress),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
