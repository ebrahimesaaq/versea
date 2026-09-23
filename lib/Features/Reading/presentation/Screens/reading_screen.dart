import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:versea/Features/Reading/presentation/widgets/end_reading_button.dart';
import 'package:versea/Features/Reading/presentation/widgets/head_of_reading_screen.dart';
import 'package:versea/Features/Reading/presentation/widgets/save_reading_functions.dart';
import 'package:versea/Features/Reading/presentation/widgets/verses_list_view_builder.dart';

import 'package:versea/generated/l10n.dart';
import 'package:versea/main.dart';
import 'package:versea/services/connectivity_checker.dart';

import 'package:versea/utils/Core/custom_scaffold.dart';
import 'package:versea/utils/Core/widgets/custom_app_bar.dart';
import 'package:versea/utils/data_source/local_data_source/bible_book_model.dart';
import 'package:versea/utils/routes/home_refresh_notifier.dart';

class ReadingScreen extends StatefulWidget {
  final BibleBookModel book;
  final int chapterID;

  const ReadingScreen({super.key, required this.book, required this.chapterID});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  final ScrollController scrollController = ScrollController();

  late int chapterId;
  double verseFontSize = prefs?.getDouble('font_size') ?? 18;
  late double initialFontSize;
  Map<String, dynamic> data = {};
  List<String> verses = [];

  late Future<void> getAVerses;

  Future<void> getVerses() async {
    final jsonString = await rootBundle.loadString(
      'assets/bible/arb_vdv/${widget.book.code}/$chapterId.json',
    );

    data = json.decode(jsonString);

    verses.clear();

    for (final item in data['chapter']['content']) {
      if (item['type'] == 'verse') {
        verses.add(item['content'][0]);
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    initialFontSize = verseFontSize;
    chapterId = widget.chapterID;

    getAVerses = getVerses();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? CustomScaffold(
            body: Column(
              children: [
                CustomAppBar(title: S.of(context).title),
                const SizedBox(height: 50),
                const Center(child: CircularProgressIndicator()),
              ],
            ),
          )
        : CustomScaffold(
            body: Column(
              children: [
                CustomAppBar(title: S.of(context).title),

                const SizedBox(height: 50),

                HeadOfReadingPage(
                  onChapterChanged: (chapter) async {
                    chapterId = chapter;

                    await getVerses();

                    if (!mounted) return;

                    await scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },

                  book: widget.book,

                  chapterID: chapterId,

                  data: data,
                ),

                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        GestureDetector(
                          onScaleStart: (details) {
                            initialFontSize = verseFontSize;
                          },
                          onScaleUpdate: (details) {
                            if (details.pointerCount >= 2) {
                              setState(() {
                                verseFontSize =
                                    (initialFontSize * details.scale).clamp(
                                      12.00,
                                      40.00,
                                    );
                              });
                            }
                          },
                          onScaleEnd: (details) {
                            prefs!.setDouble('font_size', verseFontSize);
                          },
                          child: VersesListViewBuilder(
                            verses: verses,
                            fontSize: verseFontSize,
                          ),
                        ),

                        const SizedBox(height: 30),

                        EndReadingButton(
                          onPressed: () {
                            endReadingFunction(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Future<void> endReadingFunction(BuildContext context) async {
    final bookId = widget.book.id;

    final bool connected = await ConnectionChecker().check();

    if (connected) {
      await onlineSave(bookId, context);
    } else {
      await offlineSave(bookId, context);
    }
  }

  Future<void> onlineSave(dynamic bookId, BuildContext context) async {
    if (chapterId < widget.book.chapters) {
      // الفصل الذي انتهى المستخدم من قراءته
      final int previousChapter = chapterId;

      // الانتقال للفصل التالي
      chapterId++;

      // تحميل الفصل الجديد
      await getVerses();

      // حفظ التقدم على Firebase
      InterNetConnectedSaveReadingFunctions().notLastChapter(
        bookId,
        widget.book.name,
        widget.book.chapters,
        previousChapter,
      );
      if (!mounted) return;

      // العودة إلى بداية الفصل الجديد
      await scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // المستخدم أنهى آخر فصل
      await InterNetConnectedSaveReadingFunctions().lastChapter(
        bookId,
        widget.book.name,
      );
      homeRefreshNotifier.value++;
      if (!mounted) return;

      Navigator.pop(context);
    }
  }

  Future<void> offlineSave(dynamic bookId, BuildContext context) async {
    if (chapterId < widget.book.chapters) {
      // الفصل الذي انتهى المستخدم من قراءته
      final int previousChapter = chapterId;

      // الانتقال للفصل التالي
      chapterId++;

      // تحميل الفصل الجديد
      await getVerses();

      // حفظ التقدم محليًا
      InternetDisconnectedSaveReadingFunctions().notLastChapter(
        bookId,
        widget.book.name,
        widget.book.chapters,
        previousChapter,
      );

      if (!mounted) return;

      // العودة إلى بداية الفصل الجديد
      await scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // المستخدم أنهى آخر فصل
      InternetDisconnectedSaveReadingFunctions().lastChapter(
        bookId,
        widget.book.name,
      );
      homeRefreshNotifier.value++;
      if (!mounted) return;

      Navigator.pop(context);
    }
  }
}
