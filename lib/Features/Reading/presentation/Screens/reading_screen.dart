import 'package:flutter/material.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/utils/Core/custom_scaffold.dart';
import 'package:versea/utils/Core/widgets/custom_app_bar.dart';

class ReadingScreen extends StatefulWidget {
  final int bookId;
  final String bookName;
  final int chapterCount;
  const ReadingScreen({
    super.key,
    required this.bookId,
    required this.bookName,
    required this.chapterCount,
  });

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          CustomAppBar(title: S.of(context).title),
          // Text("${widget.bookId}"),
          Text(
            widget.bookName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            '${widget.chapterCount}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
