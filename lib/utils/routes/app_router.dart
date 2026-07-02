import 'package:go_router/go_router.dart';
import 'package:versea/Features/Bible/presentation/Screens/testament_screen.dart';
import 'package:versea/Features/Home/presentation/Screens/home_screen.dart';
import 'package:versea/Features/Reading/presentation/Screens/reading_screen.dart';

class AppRouter {
  static const kHomeView = '/homeView';
  static const kTestamentScreen = '/testamentScreen';
  static const kReadingScreen = '/readingScreen';
  static final router = GoRouter(
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

          final bookId = data['bookId'];
          final bookName = data['bookName'];
          final chapterCount = data['chapterCount'];

          return ReadingScreen(
            bookId: bookId,
            bookName: bookName,
            chapterCount: chapterCount,
          );
        },
      ),
    ],
  );
}
