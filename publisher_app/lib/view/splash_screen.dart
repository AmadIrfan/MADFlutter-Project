// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../res/routes/route_name.dart';
import '../view Model/local storage/local_storage.dart';
import '../view Model/services/end_points.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    initFuc();
    getIpAddress();
    super.initState();
  }

  initFuc() {
    Timer(
      const Duration(seconds: 3),
      () async {
        if (_auth.currentUser == null) {
          Navigator.pushReplacementNamed(context, RouteName.start);
        } else {
          // Navigate to the home screen
          Navigator.pushReplacementNamed(context, RouteName.initScreen);
        }
      },
    );
  }

  getIpAddress() async {
    String? address =
        await Provider.of<LocalStorage>(context, listen: false).getServer();
    if (address != null) {
      url = address;
    } else {
      url = url;
    }
  }

  // Function to check user's "active" status in Firestore

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
