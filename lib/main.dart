import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:versea/firebase_options.dart';
import 'package:versea/utils/Core/languages/langs.dart';
import 'package:versea/utils/data_source/hive_init.dart';
import 'package:versea/utils/routes/app_router.dart';
import 'generated/l10n.dart';
import 'package:versea/utils/Core/themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  HiveInit().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: true,

      locale: Locale(Langs.ar),
      theme: AppThemes().lightTheme,
    );
  }
}
