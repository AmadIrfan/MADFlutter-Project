// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    print(userId);
    return FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .snapshots();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

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
          _auth.signOut();
          return const Scaffold(
            body: Center(
              child: Text('No data available'),
            ),
          );
        } else {
          bool isActive = snapshot.data!.data()!['active'];
          print(isActive);
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
      body: const Center(
        child: Text('Sorry, your account is inactive.'),
      ),
    );
  }
}
