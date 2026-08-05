import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VersesListViewBuilder extends StatelessWidget {
  const VersesListViewBuilder({super.key, required this.verses});

  final List<String> verses;

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
            style: TextStyle(fontSize: 18),
          ),
        );
      },
    );
  }
}
