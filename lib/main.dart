
import 'package:evently_app/config/theme/theme_manager.dart';
import 'package:evently_app/core/prefs_manager/prefs_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{ WidgetsFlutterBinding.ensureInitialized(); bool seen = await PrefsManager.checkFirstTime(); runApp( Evenlty(seen)); }

class Evenlty extends StatelessWidget {
  final bool seen;
  const Evenlty(this.seen,{super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, _)=>MaterialApp(
        debugShowCheckedModeBanner: false,
      initialRoute: seen ? RoutesManager.login : RoutesManager.onboarding,
        onGenerateRoute: RoutesManager.router,
        theme:ThemeManager.light ,
        darkTheme: ThemeManager.dark,
        themeMode: ThemeMode.light,
        supportedLocales: [
          Locale('en'),
          Locale('ar'),
          Locale('es'),
        ],
        locale: Locale('en'),

      ),

    );
  }
}
