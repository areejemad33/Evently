import 'package:evently_app/config/theme/theme_manager.dart';
import 'package:evently_app/core/prefs_manager/prefs_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/firebase_options.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/lang_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
      WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  await PrefsManager.init();

  bool seen =  PrefsManager.checkFirstTime();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LangProvider()),
      ],
      child: Evenlty(seen),
    ),
  );
}

class Evenlty extends StatelessWidget {
  final bool seen;
  const Evenlty(this.seen, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var langProvider = Provider.of<LangProvider>(context);
    return ScreenUtilInit(
      designSize: Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: seen ? RoutesManager.login : RoutesManager.onboarding,
        onGenerateRoute: RoutesManager.router,
        theme: ThemeManager.light,
        darkTheme: ThemeManager.dark,
        themeMode: themeProvider.currentTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: [Locale('en'), Locale('ar'), Locale('fr')],
        locale: Locale(langProvider.currentLang),
      ),
    );
  }
}
