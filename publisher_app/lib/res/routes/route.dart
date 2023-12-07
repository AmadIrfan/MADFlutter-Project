import 'package:flutter/material.dart';

import '../../view/add_author.dart';
import '../../view/add_books.dart';
import '../../view/add_chapter.dart';
import '../../view/books_manage.dart';
import '../../view/init_screens.dart';
import '../../view/ip_change.dart';
import '../../view/user_profile.dart';
import '../../view/user_update_screen.dart';
import '../../view/view_book_details.dart';
import '../../view/authors_manage.dart';
import '../../view/forget_password.dart';
import '../../view/home_screen.dart';
import '../../view/login_screen.dart';
import '../../view/splash_screen.dart';
import '../../view/start_screen.dart';
import '../routes/route_name.dart';

class MyRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const MyHomePage(),
        );
      case RouteName.addChapter:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const AddChapters(),
        );
      case RouteName.initScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const InitScreens(),
        );
      case RouteName.editProfile:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const PublisherUpdateScreen(),
        );
      case RouteName.profile:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const UserProfile(),
        );
      case RouteName.ipScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ChangeIpAddress(),
        );
      case RouteName.authors:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const AuthorManage(),
        );
      case RouteName.viewBook:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ViewBookDetailed(),
        );
      case RouteName.addAuthor:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const AddAuthor(),
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
      case RouteName.forgetPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ForgotPassword(),
        );
      case RouteName.addBook:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const AddBooks(),
        );
      case RouteName.manageBooks:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const BookManage(),
        );
      case RouteName.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Login(),
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
