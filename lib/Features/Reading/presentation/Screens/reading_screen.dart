import 'dart:convert';

import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/main.dart';
import 'package:versea/utils/Core/api/api_functions.dart';
import 'package:versea/utils/Core/custom_scaffold.dart';
import 'package:versea/utils/Core/widgets/custom_app_bar.dart';
import 'package:versea/utils/data_source/local_data_source/bible_book_model.dart';
import 'package:versea/utils/data_source/local_data_source/book_code.dart';
import 'package:versea/utils/routes/app_router.dart';
import 'package:versea/utils/routes/consts.dart';

class ReadingScreen extends StatefulWidget {
  final BibleBookModel book;
  final int chapterID;
  const ReadingScreen({super.key, required this.book, required this.chapterID});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  ApiFunctions apiFunctions = ApiFunctions();

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

  int verseShow = -1;

  @override
  void initState() {
    chapterId = widget.chapterID;
    getVerses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: verses.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(title: S.of(context).title),

                  SizedBox(height: 50),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.amber.withValues(alpha: 0.4),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      widget.book.id <= 39 ? 'العهد القديم' : 'العهد الجديد',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${widget.book.name}: الإصـحـــــــــاح  ${data['chapter']['number']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 160,
                        child: DropdownFlutter(
                          hintText:
                              'الإصحــــــاح ${data['chapter']['number']}',
                          // animationCurve: Curves.easeInOut,
                          decoration: CustomDropdownDecoration(
                            closedFillColor: Colors.amber.withValues(alpha: 0),
                            // expandedFillColor: Colors.amber.withValues(alpha: 1),
                          ),
                          items: List.generate(
                            widget.book.chapters,
                            (index) =>
                                ('الإصحــــــاح ${index + 1}').toString(),
                          ),

                          onChanged: (value) {
                            setState(() {
                              chapterId = int.parse(value!.split(' ').last);
                              getVerses();
                              setState(() {});
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: DropdownFlutter(
                          hintText: widget.book.name,
                          // animationCurve: Curves.easeInOut,
                          decoration: CustomDropdownDecoration(
                            closedFillColor: Colors.amber.withValues(alpha: 0),
                            // expandedFillColor: Colors.amber.withValues(alpha: 1),
                          ),
                          items: List.generate(
                            widget.book.id >= 40 ? 27 : 39,
                            (index) => widget.book.id >= 40
                                ? bibleBooks[index + 39].name
                                : bibleBooks[index].name,
                          ),

                          onChanged: (value) {
                            final selectedBook = bibleBooks.firstWhere(
                              (book) => book.name == value,
                            );

                            GoRouter.of(context).pushReplacement(
                              AppRouter.kReadingScreen,
                              extra: {'book': selectedBook, 'chapterID': 1},
                            );

                            // navigateToReadingScreen(
                            //   context: context,
                            //   book: selectedBook,
                            //   chapterID: 1,
                            // );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  ListView.builder(
                    padding: EdgeInsets.zero,

                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: verses.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onLongPress: () {
                          Clipboard.setData(ClipboardData(text: verses[index]));
                        },
                        title: Text(
                          verses[index],
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      final bookId = widget.book.id;
                      final chapter = data['chapter']['number'];

                      if (chapterId < widget.book.chapters) {
                        chapterId++;
                        getVerses();
                        if (bookId >= 40) {
                          prefs?.setString('newBookName', widget.book.name);
                          prefs?.setInt('newBookID', widget.book.id);
                          prefs?.setInt('newChapter', chapter + 1);
                          prefs?.setInt(
                            'newChapterCount',
                            widget.book.chapters,
                          );
                        } else {
                          prefs?.setString('oldBookName', widget.book.name);
                          prefs?.setInt('oldBookID', widget.book.id);
                          prefs?.setInt('oldChapter', chapter + 1);
                          prefs?.setInt(
                            'oldChapterCount',
                            widget.book.chapters,
                          );
                        }

                        setState(() {});
                      } else {
                        Navigator.pop(context);
                        if (bookId >= 40) {
                          prefs?.setString(
                            'newBookName',
                            booksData[widget.book.id]['name'],
                          );
                          prefs?.setInt('newBookID', widget.book.id + 1);
                          prefs?.setInt('newChapter', 1);
                          prefs?.setInt(
                            'newChapterCount',
                            booksData[widget.book.id]['chapters'],
                          );
                        } else {
                          prefs?.setString(
                            'oldBookName',
                            booksData[widget.book.id]['name'],
                          );
                          prefs?.setInt('oldBookID', widget.book.id + 1);
                          prefs?.setInt('oldChapter', 1);
                          prefs?.setInt(
                            'oldChapterCount',
                            booksData[widget.book.id]['chapters'],
                          );
                        }
                      }
                    },
                    child: Text('انهاء القراءة'),
                  ),
                ],
              ),
            ),
    );
  }
}
