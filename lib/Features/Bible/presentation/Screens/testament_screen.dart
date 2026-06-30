import 'package:flutter/material.dart';

import 'package:versea/Features/Bible/presentation/Widgets/chapter_card.dart';
import 'package:versea/Features/Bible/presentation/Widgets/testament_chose.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/utils/Core/api/api_functions.dart';
import 'package:versea/utils/Core/custom_scaffold.dart';
import 'package:versea/utils/Core/widgets/custom_app_bar.dart';

class TestamentScreen extends StatefulWidget {
  const TestamentScreen({super.key});

  @override
  State<TestamentScreen> createState() => _TestamentScreenState();
}

class _TestamentScreenState extends State<TestamentScreen> {
  bool isOldTestament = false;

  ApiFunctions apiFunctions = ApiFunctions();

  Map<String, dynamic> books = {};
  Map<String, dynamic> chapters = {};

  Map<String, dynamic> oldBooks = {};
  Map<String, dynamic> oldChapters = {};

  Map<String, dynamic> newBooks = {};
  Map<String, dynamic> newChapters = {};

  Future<void> loadBooks() async {
    books = await apiFunctions.getBooksFunction();
    chapters = await apiFunctions.getChaptersFunction();

    int newIndex = 1;
    int oldIndex = 1;

    for (int index = 1; index < books.length; index++) {
      if (index >= 50) {
        newBooks[newIndex.toString()] = books[index.toString()];
        newChapters[newIndex.toString()] = chapters[index.toString()];
        newIndex++;
      } else {
        oldBooks[oldIndex.toString()] = books[index.toString()];
        oldChapters[oldIndex.toString()] = chapters[index.toString()];
        oldIndex++;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    loadBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool modeIsLight = Theme.of(context).brightness == Brightness.light;

    return CustomScaffold(
      body: ListView(
        children: [
          CustomAppBar(title: S.of(context).title),
          Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.of(context).bible,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TestamentChose(
                  modeIsLight: modeIsLight,
                  isNew: !isOldTestament,
                  onNewTap: () {
                    isOldTestament = false;
                    setState(() {});
                  },
                  onOldTap: () {
                    isOldTestament = true;
                    setState(() {});
                  },
                ),
                SizedBox(height: 20),
                GridView.builder(
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
                    return ChapterCard(
                      modeIsLight: modeIsLight,
                      bookName: bookName,
                      chapterCount: chapterCount,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
