import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:versea/Features/Bible/presentation/Widgets/chapter_card.dart';
import 'package:versea/utils/routes/app_router.dart';

class ChaptersGridViewBuilder extends StatelessWidget {
  final bool isOldTestament;
  final bool modeIsLight;
  final Map<String, dynamic> oldBooks;
  final Map<String, dynamic> oldChapters;
  final Map<String, dynamic> newBooks;
  final Map<String, dynamic> newChapters;
  const ChaptersGridViewBuilder({
    super.key,
    required this.isOldTestament,
    required this.modeIsLight,
    required this.oldBooks,
    required this.oldChapters,
    required this.newBooks,
    required this.newChapters,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 16 / 11,
        crossAxisCount: 2,
      ),

      itemCount: isOldTestament ? oldBooks.length : newBooks.length,
      itemBuilder: (context, index) {
        final bookName = isOldTestament
            ? oldBooks[(index + 1).toString()].toString()
            : newBooks[(index + 1).toString()].toString();
        final chapterCount = isOldTestament
            ? oldChapters[(index + 1).toString()].toString()
            : newChapters[(index + 1).toString()].toString();

        final bookId = isOldTestament ? index + 1 : index + 50;

        final bookNameForReading = isOldTestament
            ? oldBooks[(index + 1).toString()].toString()
            : newBooks[(index + 1).toString()].toString();

        final chapterCountForReading = int.parse(chapterCount);

        return InkWell(
          onTap: () {
            navigateToReadingScreen(
              chapterID: 1,
              context: context,
              bookId: bookId,
              bookNameForReading: bookNameForReading,
              chapterCountForReading: chapterCountForReading,
            );
          },
          child: ChapterCard(
            modeIsLight: modeIsLight,
            bookName: bookName,
            chapterCount: chapterCount,
          ),
        );
      },
    );
  }
}

void navigateToReadingScreen({
  required BuildContext context,
  required int bookId,
  required String bookNameForReading,
  required int chapterCountForReading,
  required int chapterID,
}) {
  GoRouter.of(context).push(
    AppRouter.kReadingScreen,
    extra: {
      'bookId': bookId,
      'bookName': bookNameForReading,
      'chapterCount': chapterCountForReading,
      'chapterID': chapterID,
    },
  );
}
