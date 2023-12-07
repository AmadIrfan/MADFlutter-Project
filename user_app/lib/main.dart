import 'package:flutter/material.dart';

import "package:provider/provider.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:user_app/view%20model/local_storage.dart';

import './view%20model/provider/user_provider.dart';
import './view%20model/services/api_calls.dart';
import '../res/colors.dart';
import '../res/routes/route_name.dart';
import 'view model/firebase_methods.dart';
import '../res/routes/route.dart';
import 'firebase_options.dart';

// main function
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// App starting point MY-APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // building professional app look
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FireBaseMethods(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ApiCalls(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalStorage(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Managa\'s verse',
        theme: ThemeData(
          fontFamily: fontFamily,
          buttonTheme: const ButtonThemeData(
            buttonColor: darkBlueColor,
            height: 60,
          ),
          primaryColor: darkBlueColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: darkBlueColor,
          ),
          useMaterial3: true,
        ),
        initialRoute: RouteName.splash,
        onGenerateRoute: MyRoute.generateRoute,
      ),
    );
  }
}
