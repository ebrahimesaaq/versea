import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:versea/Features/Home/presentation/Widgets/categories_category.dart';
import 'package:versea/Features/Home/presentation/Widgets/continue_reading_widget.dart';
import 'package:versea/Features/Home/presentation/Widgets/verse_of_the_day_category.dart';
import 'package:versea/Features/Home/presentation/Widgets/welcome_category.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/main.dart';
import 'package:versea/utils/Core/custom_scaffold.dart';
import 'package:versea/utils/Core/widgets/custom_app_bar.dart';
import 'package:versea/utils/routes/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
        },
        child: ListView(
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
                  prefs!.getInt('newBookID') == null &&
                          prefs!.getInt('oldBookID') == null
                      ? SizedBox()
                      : ContinueReadingWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
