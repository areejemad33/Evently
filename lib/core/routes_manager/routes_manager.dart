
import 'package:evently_app/features/auth/login/login_screen.dart';
import 'package:evently_app/features/auth/register/register_screen.dart';
import 'package:evently_app/features/create_event/create_event.dart';
import 'package:evently_app/features/home/home_screen.dart';
import 'package:evently_app/features/onbording/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager{
    static const String onboarding = '/onBoarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String homeScreen = '/homeScreen';
  static const String createEvent = '/createEvent';
  static Route? router(RouteSettings settings){
    switch(settings.name){
          case onboarding:{
        return CupertinoPageRoute(builder: (_)=>OnboardingScreen());
      }
      case login:{
        return CupertinoPageRoute(builder: (_)=>LoginScreen());
      }
      case register:{
        return CupertinoPageRoute(builder: (_)=>RegisterScreen());
      }
      case homeScreen:{
        return CupertinoPageRoute(builder: (_)=>HomeScreen());
      }
      case createEvent:{
        return CupertinoPageRoute(builder: (_)=>CreateEvent());
      }
    }
    return null;
  }
}

