import 'package:flutter/material.dart';
import 'package:versea/Features/Home/presentation/Widgets/categories_category.dart';
import 'package:versea/Features/Home/presentation/Widgets/continue_reading_card.dart';
import 'package:versea/Features/Home/presentation/Widgets/verse_of_the_day_category.dart';
import 'package:versea/Features/Home/presentation/Widgets/welcome_category.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/utils/Core/custom_scaffold.dart';
import 'package:versea/utils/Core/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          CustomAppBar(title: S.of(context).title),
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WelcomeCategory(),
                VerseOfTheDayCategory(),
                CategoriesCategory(),
                SizedBox(height: 12),
                Text(
                  S.of(context).continueReading,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                ContinueReadingCard(isOldTestament: true, progress: 0.6),
                ContinueReadingCard(isOldTestament: false, progress: 0.3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
