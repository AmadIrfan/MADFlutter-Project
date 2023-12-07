import 'package:flutter/material.dart';

import '../../views/books_manage.dart';
import '../../views/ip_change.dart';
import '../../views/email_send.dart';
import '../../views/forget_password.dart';
import '../../views/init_screens.dart';
import '../../views/user_profile.dart';
import '../../views/user_update_screen.dart';
import '../../views/view_book_details.dart';
import '../../views/add_publisher.dart';
import '../../views/login_screen.dart';
import '../../views/publisher_view_details.dart';
import '../../views/publishers_view.dart';
import '../../views/signup_screen.dart';
import '../../views/splash_screen.dart';
import '../../views/staff_manage.dart';
import '../../views/start_screen.dart';
import '../../views/user_manage.dart';
import '../../views/view_detail.dart';
import '../../views/home_screen.dart';

import '../routes/route_name.dart';

// handle routing of app to go another screen
class MyRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const MyHomePage(),
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
      case RouteName.ipChange:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ChangeIpAddress(),
        );
      case RouteName.email:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SendEmailPage(),
        );
      case RouteName.profile:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const UserProfile(),
        );
      case RouteName.viewBook:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ViewBookDetailed(),
        );
      case RouteName.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Login(),
        );
      case RouteName.userManage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const UserManage(),
        );
      case RouteName.viewDetailed:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ViewDetails(),
        );
      case RouteName.addPublisher:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const AddPublisher(),
        );
      case RouteName.books:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const BookManage(),
        );
      case RouteName.staffManage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const StaffManage(),
        );
      case RouteName.forgetPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ForgotPassword(),
        );
      case RouteName.init:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const InitScreens(),
        );
      case RouteName.editProfile:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const AdminUpdateScreen(),
        );
      case RouteName.publisherManage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const PublisherManage(),
        );
      case RouteName.publisherView:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const PublisherViewDetails(),
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
