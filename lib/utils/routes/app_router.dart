import 'package:go_router/go_router.dart';
import 'package:versea/Features/Bible/presentation/Screens/testament_screen.dart';
import 'package:versea/Features/Home/presentation/Screens/home_screen.dart';

class AppRouter {
  static const kHomeView = '/homeView';
  static const kTestament = '/testament';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: kTestament,
        builder: (context, state) => const TestamentScreen(),
      ),
    ],
  );
}
