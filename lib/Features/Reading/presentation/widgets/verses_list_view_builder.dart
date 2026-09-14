import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VersesListViewBuilder extends StatelessWidget {
  const VersesListViewBuilder({
    super.key,
    required this.verses,
    required this.fontSize,
  });

  final List<String> verses;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
            '${index + 1} ${verses[index]}',
            style: TextStyle(fontSize: fontSize),
          ),
        );
      },
    );
  }
}
