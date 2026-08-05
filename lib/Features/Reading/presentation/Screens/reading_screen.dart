import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:versea/Features/Reading/presentation/widgets/end_reading_button.dart';

import 'package:versea/Features/Reading/presentation/widgets/head_of_reading_screen.dart';
import 'package:versea/Features/Reading/presentation/widgets/verses_list_view_builder.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/main.dart';

import 'package:versea/utils/Core/custom_scaffold.dart';
import 'package:versea/utils/Core/widgets/custom_app_bar.dart';
import 'package:versea/utils/data_source/local_data_source/bible_book_model.dart';

import 'package:versea/utils/routes/consts.dart';

class ReadingScreen extends StatefulWidget {
  final BibleBookModel book;
  final int chapterID;
  const ReadingScreen({super.key, required this.book, required this.chapterID});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  ScrollController scrollController = ScrollController();
  late int chapterId;

  Map<String, dynamic> data = {};
  List<String> verses = [];

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

    setState(() {});
  }

  late Future<void> getAVerses;

  @override
  void initState() {
    chapterId = widget.chapterID;
    getAVerses = getVerses();
    super.initState();
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
                SizedBox(height: 50),
                Center(child: CircularProgressIndicator()),
              ],
            ),
          )
        : CustomScaffold(
            body: Column(
              children: [
                CustomAppBar(title: S.of(context).title),
                SizedBox(height: 50),
                HeadOfReadingPage(
                  onChapterChanged: (chapter) async {
                    chapterId = chapter;
                    await getVerses();
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
                        VersesListViewBuilder(verses: verses),
                        SizedBox(height: 30),
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

  void endReadingFunction(BuildContext context) async {
    final bookId = widget.book.id;
    final chapter = data['chapter']['number'];

    if (chapterId < widget.book.chapters) {
      chapterId++;
      getVerses();
      chapterIsNotLastChapter(bookId, chapter);
      await scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      setState(() {});
    } else {
      Navigator.pop(context);
      chapterIsLastChapter(bookId);
    }
  }

  void chapterIsLastChapter(int bookId) {
    if (bookId >= 40) {
      prefs?.setString('newBookName', booksData[widget.book.id]['name']);
      prefs?.setInt('newBookID', widget.book.id + 1);
      prefs?.setInt('newChapter', 1);
      prefs?.setInt('newChapterCount', booksData[widget.book.id]['chapters']);
    } else {
      prefs?.setString('oldBookName', booksData[widget.book.id]['name']);
      prefs?.setInt('oldBookID', widget.book.id + 1);
      prefs?.setInt('oldChapter', 1);
      prefs?.setInt('oldChapterCount', booksData[widget.book.id]['chapters']);
    }
  }

  void chapterIsNotLastChapter(int bookId, chapter) {
    if (bookId >= 40) {
      prefs?.setString('newBookName', widget.book.name);
      prefs?.setInt('newBookID', widget.book.id);
      prefs?.setInt('newChapter', chapter + 1);
      prefs?.setInt('newChapterCount', widget.book.chapters);
    } else {
      prefs?.setString('oldBookName', widget.book.name);
      prefs?.setInt('oldBookID', widget.book.id);
      prefs?.setInt('oldChapter', chapter + 1);
      prefs?.setInt('oldChapterCount', widget.book.chapters);
    }
  }
}
