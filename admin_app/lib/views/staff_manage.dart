import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';
import '../widgets/chart.dart';
import '../data/firebase_methods.dart';
import '../data/provider/user_provider.dart';
import '../res/colors.dart';
import '../widgets/admins_card.dart';

// activate and deactivate staff manage
class StaffManage extends StatefulWidget {
  const StaffManage({super.key});

  @override
  State<StaffManage> createState() => _StaffManageState();
}

class _StaffManageState extends State<StaffManage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? filter = 'all';

  Stream<QuerySnapshot<Map<String, dynamic>>> collection =
      FirebaseFirestore.instance.collection('admin').snapshots();
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<FireBaseMethods>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false);
    user.refreshUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Staff Manage'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Column(
          children: [
            Container(
              color: darkBlueColor.withOpacity(0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilterChip(
                    selected: filter == 'all' ? true : false,
                    onSelected: (v) {
                      setState(() {
                        collection = _firestore.collection('admin').snapshots();
                      });
                      filter = 'all';
                    },
                    label: const Text('All'),
                  ),
                  FilterChip(
                    selected: filter == 'active' ? true : false,
                    onSelected: (v) {
                      setState(() {
                        collection = _firestore
                            .collection('admin')
                            .where(
                              'active',
                              isEqualTo: true,
                            )
                            .snapshots();
                      });
                      filter = 'active';
                    },
                    label: const Text('Active'),
                  ),
                  FilterChip(
                    selected: filter == 'inActive' ? true : false,
                    onSelected: (v) {
                      setState(() {
                        collection = _firestore
                            .collection('admin')
                            .where(
                              'active',
                              isEqualTo: false,
                            )
                            .snapshots();
                      });
                      filter = 'inActive';
                    },
                    label: const Text('In Active'),
                  ),
                ],
              ),
            ),
            FutureBuilder<Map<String, double>>(
              future: data.calculateUserStats('admin'),
              // Assuming fetchData is an async function that returns Future<Map<String, double>>
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, double>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While data is being fetched, you can return a loading indicator or something else.
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // If an error occurs during fetching, handle it appropriately.
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Data has been successfully fetched, pass it to the PIChart widget.
                  return PIChart(chartName: 'Statistics', data: snapshot.data!);
                }
              },
            ),
            Expanded(
              child: StreamBuilder(
                stream: collection,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else {
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text('No document Found'),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          UserModel u = UserModel.fromMap(
                            snapshot.data!.docs[index].data(),
                          );
                          if (user.getUser!.id != u.id) {
                            return ADminCards(
                              userModel: u,
                            );
                          }

                          return const SizedBox();
                        });
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
