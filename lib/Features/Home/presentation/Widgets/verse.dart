import 'package:flutter/material.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/utils/Core/app_colors.dart';

class Verse extends StatelessWidget {
  const Verse({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          S.of(context).verseOfTheDay,
          style: TextStyle(color: LightAppColors.secondaryColor, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12),
        Text(
          '"أَسْتَطِيعُ كُلَّ شَيْءٍ فِي الْمَسِيحِ الَّذِي يُقَوِّينِي"',
          style: TextStyle(
            backgroundColor:
                (!isDark
                        ? DarkAppColors2.tertiaryColor
                        : DarkAppColors2.neutralColor)
                    .withValues(alpha: 0.5),
            fontSize: 22,

            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: isDark
                ? DarkAppColors2.tertiaryColor
                : DarkAppColors2.neutralColor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12),
        Text(
          'فيلبي 4:13',

          style: TextStyle(
            backgroundColor:
                (!isDark
                        ? DarkAppColors2.tertiaryColor
                        : DarkAppColors2.neutralColor)
                    .withValues(alpha: 0.5),
            fontSize: 16,

            color: isDark
                ? DarkAppColors2.tertiaryColor
                : DarkAppColors2.neutralColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
