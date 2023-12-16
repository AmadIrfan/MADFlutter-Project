import 'package:flutter/material.dart';

import '../../views/user_profile.dart';
import '../../views/chapter.dart';
import '../../views/user_updatescreen.dart';
import '../../views/view_book_details.dart';
import '../../views/init_screens.dart';
import '../../views/login_screen.dart';
import '../../views/signup_screen.dart';
import '../../views/splash_screen.dart';
import '../../views/start_screen.dart';
import '../routes/route_name.dart';
import '../../views/home_screen.dart';

class MyRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const MyHomePage(),
        );
      case RouteName.viewBookDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ViewBookDetails(),
        );
      case RouteName.splash:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SplashScreen(),
        );
      case RouteName.start:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const StartScreen(),
        );
      case RouteName.signup:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Signup(),
        );
      case RouteName.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Login(),
        );
      case RouteName.viewBookChapter:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ChapterView(),
        );
      case RouteName.init:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const InitScreens(),
        );
      case RouteName.updateScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const UserUpdateScreen(),
        );
      case RouteName.profile:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const UserProfile(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No Route'),
            ),
          ),
        );
    }
  }
}
