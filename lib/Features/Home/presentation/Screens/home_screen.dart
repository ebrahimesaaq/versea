import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:versea/Features/Bible/presentation/Screens/testament_screen.dart';
import 'package:versea/Features/Home/presentation/Widgets/continue_reading_widget.dart';
import 'package:versea/Features/Home/presentation/Widgets/settings_page.dart';
import 'package:versea/Features/Home/presentation/Widgets/verse_of_the_day_category.dart';
import 'package:versea/Features/Home/presentation/Widgets/welcome_category.dart';
import 'package:versea/generated/l10n.dart';
import 'package:versea/main.dart';
import 'package:versea/utils/Core/custom_scaffold.dart';
import 'package:versea/utils/Core/widgets/custom_app_bar.dart';
import 'package:versea/utils/routes/home_refresh_notifier.dart';
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
  void didPopNext() {
    homeRefreshNotifier.value++;
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: PersistentTabView(
        margin: EdgeInsets.all(4),
        tabs: [
          PersistentTabConfig(
            screen: HomePageListView(),
            item: ItemConfig(
              icon: Icon(Icons.home_outlined),
              title: 'الصفحة الرئيسية',
            ),
          ),
          PersistentTabConfig(
            screen: TestamentScreen(),
            item: ItemConfig(
              icon: Icon(Icons.menu_book_rounded),
              title: 'الكتاب المقدس',
            ),
          ),
          PersistentTabConfig(
            screen: SettingsPage(),
            item: ItemConfig(
              icon: Icon(Icons.settings_outlined),
              title: 'الاعدادات',
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) =>
            Style9BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}

class HomePageListView extends StatefulWidget {
  const HomePageListView({super.key});

  @override
  State<HomePageListView> createState() => _HomePageListViewState();
}

class _HomePageListViewState extends State<HomePageListView> with RouteAware {
  @override
  void initState() {
    super.initState();

    homeRefreshNotifier.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    homeRefreshNotifier.removeListener(_refresh);
    super.dispose();
  }

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
                // CategoriesCategory(),
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
    );
  }
}
