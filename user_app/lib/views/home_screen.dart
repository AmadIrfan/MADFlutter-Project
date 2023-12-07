import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/routes/route_name.dart';
import 'package:user_app/view%20model/services/api_calls.dart';
import 'package:user_app/views/drawer.dart';

import '../view model/provider/user_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
       UserProvider up = Provider.of<UserProvider>(context, listen: false);
          up.refreshUser();
          
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Novel/Comics',
          style: TextStyle(
            color: Color(0xFF292A38),
            fontSize: 25,
            fontFamily: 'Cabin Condensed',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        leading: const SizedBox(),
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
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(10),
            const Row(
              children: [
                Gap(10),
                Text(
                  'Recommended for you :',
                  style: TextStyle(
                    color: Color(0xFF292A38),
                    fontSize: 20,
                    fontFamily: 'HK Grotesk',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ],
            ),
            const Gap(10),
            SizedBox(
              height: 200,
              child: FutureBuilder(
                future: Provider.of<ApiCalls>(context, listen: false)
                    .getLatestPublications(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.data!.length >= 10
                          ? 10
                          : snapshot.data!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteName.viewBookDetails,
                              arguments: snapshot.data!.data![index],
                            );
                          },
                          child: Container(
                            height: 100,
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(),
                            // color: Colors.amber,
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    // blurStyle: BlurStyle.outer,
                                    blurRadius: 10,
                                    offset: Offset(0, 10),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: snapshot.data!.data![index].images!.isEmpty
                                  ? Image.asset(
                                      'assets/images/bg.png',
                                      // color: Colors.blue,
                                    )
                                  : Image.network(
                                      snapshot.data!.data![index].images!.first
                                          .toString(),
                                      // color: Colors.green,
                                    ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const Gap(20),
            const Row(
              children: [
                Gap(10),
                Text(
                  'Popular  Novels\n',
                  style: TextStyle(
                    color: Color(0xFF292A38),
                    fontSize: 20,
                    fontFamily: 'Cabin Condensed',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: Provider.of<ApiCalls>(context, listen: false)
                    .getLatestPublications(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Container(
                            height: 100,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(),
                            child: Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 35,
                                        offset: Offset(0, 10),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: snapshot
                                          .data!.data![index].images!.isEmpty
                                      ? Image.asset(
                                          'assets/images/bg.png',
                                        )
                                      : Image.network(
                                          snapshot
                                              .data!.data![index].images!.first
                                              .toString(),
                                        ),
                                ),
                                const Gap(20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.data![index].name
                                          .toString(),
                                      style: const TextStyle(
                                        color: Color(0xFF4D506C),
                                        fontSize: 20,
                                        fontFamily: 'HK Grotesk',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                    const Gap(10),
                                    Text(
                                      snapshot.data!.data![index].category
                                          .toString(),
                                      style: const TextStyle(
                                        color: Color(0xFF4D506C),
                                        fontSize: 14,
                                        fontFamily: 'HK Grotesk',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                    const Gap(10),
                                    Text(
                                      snapshot.data!.data![index].genre
                                          .toString(),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteName.viewBookDetails,
                                      arguments: snapshot.data!.data![index],
                                    );
                                  },
                                  child: Container(
                                    width: 78,
                                    height: 26,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF171B36),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x3F000000),
                                          blurRadius: 45,
                                          offset: Offset(0, 4),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Grab Now',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'HK Grotesk',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
