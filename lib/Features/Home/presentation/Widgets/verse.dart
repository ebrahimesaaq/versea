import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:versea/Features/Home/data/cubits/verse_of_day_cubit/verse_of_day_cubit.dart';
import 'package:versea/Features/Home/data/cubits/verse_of_day_cubit/verse_of_day_states.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/utils/Core/app_colors.dart';

class Verse extends StatelessWidget {
  const Verse({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocProvider<VerseOfDayCubit>(
      create: (context) => VerseOfDayCubit()..verseOfTheDay(),
      child: BlocBuilder<VerseOfDayCubit, VerseOfDayStates>(
        builder: (context, state) {
          if (state is VerseOfDayLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is VerseOfDaySuccess) {
            return VerseWidget(isDark: isDark, verseOfDay: state.data);
          }

          if (state is VerseOfDayFailure) {
            return VerseWidget(
              isDark: isDark,
              verseOfDay: {
                'text': state.message,
                'bookName': 'Error',
                'chapterID': 0,
                'verseID': 0,
              },
            );
          }
          return VerseWidget(
            isDark: isDark,
            verseOfDay: {
              'text': 'Error',
              'bookName': 'Error',
              'chapterID': 0,
              'verseID': 0,
            },
          );
        },
      ),
    );
  }
}

class VerseWidget extends StatelessWidget {
  const VerseWidget({
    super.key,
    required this.isDark,
    required this.verseOfDay,
  });

  final bool isDark;
  final Map<String, dynamic> verseOfDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.of(context).verseOfTheDay,
          style: TextStyle(color: LightAppColors.secondaryColor, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12),
        Text(
          verseOfDay['text'],

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
          '${verseOfDay['bookName']} ${verseOfDay['verseID']}:${verseOfDay['chapterID']}',
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
