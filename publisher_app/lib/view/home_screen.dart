// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../res/colors.dart';
import '../view%20Model/services/api_calls.dart';
import '../res/routes/route_name.dart';
import '../view Model/provider/user_provider.dart';
import '../widgets/chart.dart';
import './drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> checkUserStatus(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firebaseFirestore.collection('publisher').doc(userId).get();
      // Assuming "active" is a boolean field in the user's document
      bool isActive = userDoc['active'];
      return isActive;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context, listen: false);
    up.refreshUser();
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () async {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: Provider.of<APICalls>(context, listen: false)
                    .getBookStatistics(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return PIChart(
                    data: snapshot.data!,
                    chartName: 'Books',
                  );
                }),
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteName.addBook,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: darkBlueColor,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteName.manageBooks,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: darkBlueColor,
                        ),
                        child: const Icon(
                          Icons.book,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
