// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../data/firebase_methods.dart';
import '../res/routes/route_name.dart';
import '../utils/utils.dart';
import 'home_screen.dart';

class InitScreens extends StatefulWidget {
  const InitScreens({Key? key}) : super(key: key);

  @override
  _InitScreensState createState() => _InitScreensState();
}

class _InitScreensState extends State<InitScreens> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late StreamController<DocumentSnapshot<Map<String, dynamic>>>
      _streamController;

  @override
  void initState() {
    super.initState();
    _streamController =
        StreamController<DocumentSnapshot<Map<String, dynamic>>>();
    _startStream();
  }

  void _startStream() {
    _getUserStream(_auth.currentUser?.uid ?? '').listen((snapshot) {
      _streamController.add(snapshot);
    }, onError: (error) {});
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> _getUserStream(String userId) {
    return FirebaseFirestore.instance
        .collection('admin')
        .doc(userId)
        .snapshots();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

// this screen ensure active and inactive user navigate to there screens
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.data == null || snapshot.data!.data() == null) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No data available'),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await Provider.of<FireBaseMethods>(context,
                                  listen: false)
                              .logOut();
                          Utils().showToast('SignOut successfully');
                          Navigator.pushReplacementNamed(
                            context,
                            RouteName.start,
                          );
                        } catch (e) {
                          Utils().showToast(e);
                        }
                      },
                      child: const Text('Log Out'),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          bool isActive = snapshot.data!.data()!['active'];
          if (isActive) {
            return const MyHomePage();
          } else {
            return const InactiveScreen();
          }
        }
      },
    );
  }
}

class InactiveScreen extends StatelessWidget {
  const InactiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inactive Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sorry, your account is inactive.'),
            ElevatedButton(
              onPressed: () async {
                try {
                  await Provider.of<FireBaseMethods>(context, listen: false)
                      .logOut();
                  Utils().showToast('SignOut successfully');
                  Navigator.pushReplacementNamed(
                    context,
                    RouteName.start,
                  );
                } catch (e) {
                  Utils().showToast(e);
                }
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
