import 'package:go_router/go_router.dart';
import 'package:versea/Features/Bible/presentation/Screens/testament_screen.dart';
import 'package:versea/Features/Home/presentation/Screens/home_screen.dart';
import 'package:versea/Features/Reading/presentation/Screens/reading_screen.dart';
import 'package:versea/utils/data_source/local_data_source/bible_book_model.dart';
import 'package:versea/utils/routes/route_observer.dart';

class AppRouter {
  static const kHomeView = '/homeView';
  static const kTestamentScreen = '/testamentScreen';
  static const kReadingScreen = '/readingScreen';
  static final router = GoRouter(
    observers: [routeObserver],
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: kTestamentScreen,
        builder: (context, state) => const TestamentScreen(),
      ),
      GoRoute(
        path: kReadingScreen,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          final BibleBookModel book = data['book'];
          final int chapterID = data['chapterID'];

          return ReadingScreen(book: book, chapterID: chapterID);
        },
      ),
    ],
  );
}
