import 'package:flutter/material.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/utils/Core/assets.dart';

class ContinueReadingCard extends StatelessWidget {
  final bool isOldTestament;

  final double progress;

  const ContinueReadingCard({
    super.key,
    required this.isOldTestament,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: Image.asset(
                isOldTestament
                    ? Assets.oldTestamentIcon
                    : Assets.newTestamentIcon,
                width: 90,
              ),
            ),
            SizedBox(width: 8),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isOldTestament
                        ? S.of(context).oldTestament
                        : S.of(context).newTestament,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    isOldTestament ? 'سفر التكوين' : "انجيل متى",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 12),

                  LinearProgressIndicator(value: progress),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
