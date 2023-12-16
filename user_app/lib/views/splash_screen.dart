import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../res/routes/route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    initFunc();
    super.initState();
  }

  void initFunc() {
    Timer(
      const Duration(seconds: 3),
      () {
        if (_auth.currentUser == null) {
          Navigator.pushReplacementNamed(context, RouteName.start);
        } else {
          Navigator.pushReplacementNamed(context, RouteName.init);
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF171B36),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/Group.png'),
        ],
      ),
    );
  }
}
