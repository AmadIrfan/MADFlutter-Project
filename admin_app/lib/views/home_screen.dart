// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../data/firebase_methods.dart';
import '../data/provider/user_provider.dart';
import '../res/colors.dart';
import '../res/routes/route_name.dart';
import '../views/drawer.dart';
import '../widgets/chart.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// home screen show charts and and cards to navigate to screens
class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, String>> _data = [
    {
      'name': 'User',
      'icon': 'assets/images/PhUsersDuotone.svg',
      'page': RouteName.userManage,
    },
    {
      'name': 'Books',
      'icon': 'assets/images/Group.svg',
      'page': RouteName.books,
    },
    {
      'name': 'Staff Member',
      'icon': 'assets/images/TdesignUsergroup.svg',
      'page': RouteName.staffManage,
    },
    {
      'name': 'Publishers',
      'icon': 'assets/images/PhUsersDuotone.svg',
      'page': RouteName.publisherManage,
    },
  ];

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context, listen: false);
    up.refreshUser();
    final data = Provider.of<FireBaseMethods>(context, listen: false);

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
            SizedBox(
              height: 300,
              child: FutureBuilder<Map<String, double>>(
                future: data.calculateNewRegistrations(),
                // Assuming fetchData is an async function that returns Future<Map<String, double>>
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, double>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While data is being fetched, you can return a loading indicator or something else.
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // If an error occurs during fetching, handle it appropriately.
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Data has been successfully fetched, pass it to the PIChart widget.
                    return PIChart(
                        chartName: 'User Registered in Last 24 hours',
                        data: snapshot.data!);
                  }
                },
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  _data[0]['page'].toString(),
                );
              },
              child: Container(
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: darkBlueColor,
                ),
                margin: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(),
                      child: SvgPicture.asset(
                        _data[0]['icon'].toString(),
                        height: 100,
                        width: 100,
                        color: Colors.white,
                        // fit: BoxFit.fill,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      _data[0]['name'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  _data[1]['page'].toString(),
                );
              },
              child: Container(
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: darkBlueColor,
                ),
                margin: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(),
                      child: SvgPicture.asset(
                        _data[01]['icon'].toString(),
                        height: 100,
                        width: 100,
                        color: Colors.white,
                        // fit: BoxFit.fill,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      _data[01]['name'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  _data[02]['page'].toString(),
                );
              },
              child: Container(
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: darkBlueColor,
                ),
                margin: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(),
                      child: SvgPicture.asset(
                        _data[02]['icon'].toString(),
                        height: 100,
                        width: 100,
                        color: Colors.white,
                        // fit: BoxFit.fill,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      _data[02]['name'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  _data[3]['page'].toString(),
                );
              },
              child: Container(
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: darkBlueColor,
                ),
                margin: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(),
                      child: SvgPicture.asset(
                        _data[03]['icon'].toString(),
                        height: 100,
                        width: 100,
                        color: Colors.white,
                        // fit: BoxFit.fill,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      _data[03]['name'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
