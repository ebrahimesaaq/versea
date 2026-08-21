import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:versea/utils/routes/route_observer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
          // GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
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
                  IconButton(
                    onPressed: () async {
                      GoRouter.of(
                        context,
                      ).pushReplacement(AppRouter.kLoginScreen);
                      await FirebaseAuth.instance.signOut();
                    },
                    icon: Icon(Icons.logout),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
