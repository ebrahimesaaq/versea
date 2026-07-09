import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:versea/Features/Bible/presentation/Widgets/chapters_grid_view_builder.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/main.dart';
import 'package:versea/utils/Core/api/api_functions.dart';
import 'package:versea/utils/Core/custom_scaffold.dart';
import 'package:versea/utils/Core/widgets/custom_app_bar.dart';
import 'package:versea/utils/routes/consts.dart';

class ReadingScreen extends StatefulWidget {
  final int bookId;
  final String bookName;
  final int chapterCount;
  final int chapterID;
  const ReadingScreen({
    super.key,
    required this.bookId,
    required this.bookName,
    required this.chapterCount,
    required this.chapterID,
  });

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  ApiFunctions apiFunctions = ApiFunctions();

  Map<String, dynamic> data = {};
  List verses = [];

  List<Map<String, dynamic>> sections = [];

  int verseaCount = 0;

  late int chapterId;

  Future<void> getVerses() async {
    data = await apiFunctions.getVersesFunction(
      bookId: widget.bookId,
      chapterId: chapterId,
    );

    verses = data['arr'] as List;

    verseaCount = data['verses_count'];

    sections = data['sections'].cast<Map<String, dynamic>>();

    setState(() {});
    print(verses);
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
                      int.parse(data['bookID']) >= 50
                          ? 'العهد الجديد'
                          : 'العهد القديم',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${widget.bookName}: الإصـحـــــــــاح  ${data['chapter']}',
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
                          hintText: 'الإصحــــــاح ${data['chapter']}',
                          // animationCurve: Curves.easeInOut,
                          decoration: CustomDropdownDecoration(
                            closedFillColor: Colors.amber.withValues(alpha: 0),
                            // expandedFillColor: Colors.amber.withValues(alpha: 1),
                          ),
                          items: List.generate(
                            widget.chapterCount,
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
                          hintText: booksData[widget.bookId - 1]['name'],
                          // animationCurve: Curves.easeInOut,
                          decoration: CustomDropdownDecoration(
                            closedFillColor: Colors.amber.withValues(alpha: 0),
                            // expandedFillColor: Colors.amber.withValues(alpha: 1),
                          ),
                          items: List.generate(
                            widget.bookId >= 50 ? 27 : 49,
                            (index) => widget.bookId >= 50
                                ? booksData[index + 49]['name']
                                : booksData[index]['name'],
                          ),

                          onChanged: (value) {
                            for (
                              int index = 0;
                              index < booksData.length;
                              index++
                            ) {
                              if (booksData[index]['name'] == value) {
                                setState(() {
                                  navigateToReadingScreen(
                                    context: context,
                                    bookId: index + 1,
                                    bookNameForReading:
                                        booksData[index]['name'],
                                    chapterCountForReading:
                                        booksData[index]['chapters'],
                                    chapterID: 1,
                                  );
                                  getVerses();
                                  setState(() {});
                                });
                              }
                            }
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
                    itemCount: verses.length - 1,
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
                      final bookId = int.parse(data['bookID']);
                      final chapter = int.parse(data['chapter']);

                      if (chapterId < widget.chapterCount) {
                        chapterId++;
                        getVerses();
                        if (bookId >= 50) {
                          prefs?.setString('newBookName', widget.bookName);
                          prefs?.setInt('newBookID', widget.bookId);
                          prefs?.setInt('newChapter', chapter + 1);
                          prefs?.setInt('newChapterCount', widget.chapterCount);
                        } else {
                          prefs?.setString('oldBookName', widget.bookName);
                          prefs?.setInt('oldBookID', widget.bookId);
                          prefs?.setInt('oldChapter', chapter + 1);
                          prefs?.setInt('oldChapterCount', widget.chapterCount);
                        }

                        setState(() {});
                      } else {
                        Navigator.pop(context);
                        if (bookId >= 50) {
                          prefs?.setString(
                            'newBookName',
                            booksData[widget.bookId]['name'],
                          );
                          prefs?.setInt('newBookID', widget.bookId + 1);
                          prefs?.setInt('newChapter', 1);
                          prefs?.setInt(
                            'newChapterCount',
                            booksData[widget.bookId]['chapters'],
                          );
                        } else {
                          prefs?.setString(
                            'oldBookName',
                            booksData[widget.bookId]['name'],
                          );
                          prefs?.setInt('oldBookID', widget.bookId + 1);
                          prefs?.setInt('oldChapter', 1);
                          prefs?.setInt(
                            'oldChapterCount',
                            booksData[widget.bookId]['chapters'],
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
