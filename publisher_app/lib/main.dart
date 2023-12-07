// ignore_for_file: depend_on_referenced_packages

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:firebase_core/firebase_core.dart';

import '../res/colors.dart';
import '../view Model/local storage/local_storage.dart';
import '../view Model/provider/user_provider.dart';
import '../view%20Model/services/api_calls.dart';
import '../res/routes/route_name.dart';
import '../view Model/firebase_methods.dart';
import '../res/routes/route.dart';

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
          create: (context) => APICalls(),
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
