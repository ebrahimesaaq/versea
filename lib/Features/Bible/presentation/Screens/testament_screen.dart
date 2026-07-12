import 'package:flutter/material.dart';

import 'package:versea/Features/Bible/presentation/Widgets/chapters_grid_view_builder.dart';
import 'package:versea/Features/Bible/presentation/Widgets/testament_chose.dart';
import 'package:versea/Features/Bible/presentation/functions/load_books.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/utils/Core/api/api_functions.dart';
import 'package:versea/utils/Core/custom_scaffold.dart';
import 'package:versea/utils/Core/widgets/custom_app_bar.dart';
import 'package:versea/utils/data_source/local_data_source/bible_book_model.dart';

class TestamentScreen extends StatefulWidget {
  const TestamentScreen({super.key});

  @override
  State<TestamentScreen> createState() => _TestamentScreenState();
}

class _TestamentScreenState extends State<TestamentScreen> {
  bool isOldTestament = false;

  ApiFunctions apiFunctions = ApiFunctions();

  List<BibleBookModel> oldBooks = [];
  List<BibleBookModel> newBooks = [];

  LoadBooks loadBooks = LoadBooks();

  @override
  void initState() {
    loadBooks.loadBooks(
      oldBooks: oldBooks,

      newBooks: newBooks,

      setState: () {
        setState(() {});
      },
    );

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
                ChaptersGridViewBuilder(
                  isOldTestament: isOldTestament,
                  modeIsLight: modeIsLight,
                  oldBooks: oldBooks,
                  newBooks: newBooks,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
