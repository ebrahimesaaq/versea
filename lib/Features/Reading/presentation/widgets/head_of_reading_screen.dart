import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:versea/utils/data_source/local_data_source/bible_book_model.dart';
import 'package:versea/utils/data_source/local_data_source/book_code.dart';
import 'package:versea/utils/routes/app_router.dart';

class HeadOfReadingPage extends StatefulWidget {
  final Function(int) onChapterChanged;
  final BibleBookModel book;
  final int chapterID;
  final Map<String, dynamic> data;
  const HeadOfReadingPage({
    super.key,
    required this.book,
    required this.chapterID,
    required this.data,
    required this.onChapterChanged,
  });

  @override
  State<HeadOfReadingPage> createState() => _HeadOfReadingPageState();
}

class _HeadOfReadingPageState extends State<HeadOfReadingPage> {
  late int chapterId;

  late Map<String, dynamic> pageData;

  Map<String, dynamic> data = {};

  @override
  void initState() {
    pageData = widget.data;
    chapterId = widget.chapterID;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.amber.withValues(alpha: 0.4),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            widget.book.id <= 39 ? 'العهد القديم' : 'العهد الجديد',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20),
        Text(
          '${widget.book.name}: الإصـحـــــــــاح  ${widget.data['chapter']['number']}',
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
                hintText: 'الإصحــــــاح ${widget.data['chapter']['number']}',
                // animationCurve: Curves.easeInOut,
                decoration: CustomDropdownDecoration(
                  closedFillColor: Colors.amber.withValues(alpha: 0),
                  // expandedFillColor: Colors.amber.withValues(alpha: 1),
                ),
                items: List.generate(
                  widget.book.chapters,
                  (index) => ('الإصحــــــاح ${index + 1}').toString(),
                ),

                onChanged: (value) {
                  widget.onChapterChanged(int.parse(value!.split(' ').last));
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
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
