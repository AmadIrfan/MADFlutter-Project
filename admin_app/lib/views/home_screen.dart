// ignore_for_file: deprecated_member_use

import 'package:admin_app/res/colors.dart';
import 'package:admin_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../data/firebase_methods.dart';
import '../data/provider/user_provider.dart';
import '../views/drawer.dart';
import '../widgets/chart.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// home screen show charts and and cards to navigate to screens
class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  @override
  void initState() {
    getStatisticData();
    super.initState();
  }

  Map<String, double> userLogIn = {};
  Map<String, double> admin = {};
  Map<String, double> publisher = {};
  Map<String, double> user = {};

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
      body: isLoading
          ? const Center(
              child: SpinKitFadingCircle(
                color: darkBlueColor,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: PIChart(
                      chartName: 'User Registered in Last 24 hours',
                      data: userLogIn,
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: 300,
                    child: PIChart(
                      chartName: 'Admins',
                      data: admin,
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: 300,
                    child: PIChart(
                      chartName: 'Users',
                      data: user,
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: 300,
                    child: PIChart(
                      chartName: 'publisher',
                      data: publisher,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void getStatisticData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final data = Provider.of<FireBaseMethods>(context, listen: false);
      userLogIn = await data.calculateNewRegistrations();
      admin = await data.calculateUserStats('admin');
      user = await data.calculateUserStats('user');
      publisher = await data.calculateUserStats('publisher');
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Utils().showToast(e);
    }
  }
}
