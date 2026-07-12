import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:versea/Features/Bible/presentation/Widgets/chapter_card.dart';
import 'package:versea/utils/data_source/local_data_source/bible_book_model.dart';
import 'package:versea/utils/routes/app_router.dart';

class ChaptersGridViewBuilder extends StatelessWidget {
  final bool isOldTestament;
  final bool modeIsLight;
  final List<BibleBookModel> oldBooks;
  final List<BibleBookModel> newBooks;

  const ChaptersGridViewBuilder({
    super.key,
    required this.isOldTestament,
    required this.modeIsLight,
    required this.oldBooks,
    required this.newBooks,
  });

  @override
  Widget build(BuildContext context) {
    final books = isOldTestament ? oldBooks : newBooks;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 16 / 11,
        crossAxisCount: 2,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];

        return InkWell(
          onTap: () {
            navigateToReadingScreen(context: context, book: book, chapterID: 1);
          },
          child: ChapterCard(
            modeIsLight: modeIsLight,
            bookName: book.name,
            chapterCount: book.chapters.toString(),
          ),
        );
      },
    );
  }
}

void navigateToReadingScreen({
  required BuildContext context,
  required BibleBookModel book,
  required int chapterID,
}) {
  GoRouter.of(context).push(
    AppRouter.kReadingScreen,
    extra: {'book': book, 'chapterID': chapterID},
  );
}
