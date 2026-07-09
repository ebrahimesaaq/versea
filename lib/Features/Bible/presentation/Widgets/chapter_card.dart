import 'package:flutter/material.dart';

class ChapterCard extends StatelessWidget {
  final bool modeIsLight;
  final String bookName;
  final String chapterCount;
  const ChapterCard({
    super.key,
    required this.bookName,
    required this.chapterCount,
    required this.modeIsLight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: modeIsLight
            ? Colors.brown[300]!.withValues(alpha: 0.5)
            : Colors.grey[900],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            bookName,
            maxLines: 2,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,

              overflow: TextOverflow.ellipsis,
            ),
            textAlign: TextAlign.center,
          ),
          Text('$chapterCount إصحاح', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
