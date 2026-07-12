import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:versea/Features/Home/presentation/Widgets/categories_category.dart';
import 'package:versea/Features/Home/presentation/Widgets/continue_reading_card.dart';
import 'package:versea/Features/Home/presentation/Widgets/verse_of_the_day_category.dart';
import 'package:versea/Features/Home/presentation/Widgets/welcome_category.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/main.dart';
import 'package:versea/utils/Core/custom_scaffold.dart';
import 'package:versea/utils/Core/widgets/custom_app_bar.dart';
import 'package:versea/utils/routes/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            CustomAppBar(title: S.of(context).title),
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WelcomeCategory(),
                  VerseOfTheDayCategory(),
                  CategoriesCategory(),
                  SizedBox(height: 12),
                  prefs!.getInt('newBookID') == null &&
                          prefs!.getInt('oldBookID') == null
                      ? SizedBox()
                      : ContinueReadingWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
