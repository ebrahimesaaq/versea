import 'package:go_router/go_router.dart';
import 'package:versea/Features/Bible/presentation/Screens/testament_screen.dart';
import 'package:versea/Features/Home/presentation/Screens/home_screen.dart';
import 'package:versea/Features/Reading/presentation/Screens/reading_screen.dart';
import 'package:versea/Features/authentication/presentation/screens/login_screen.dart';
import 'package:versea/Features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:versea/utils/data_source/local_data_source/bible_book_model.dart';
import 'package:versea/utils/routes/route_observer.dart';

class AppRouter {
  static const kHomeView = '/homeView';
  static const kTestamentScreen = '/testamentScreen';
  static const kReadingScreen = '/readingScreen';
  static const kLoginScreen = '/loginScreen';
  static const kSignUpScreen = '/signUpScreen';
  static final router = GoRouter(
    observers: [routeObserver],
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
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
      GoRoute(
        path: kLoginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: kSignUpScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
    ],
  );
}
