import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:publisher_app/view%20Model/services/api_calls.dart';
import 'package:publisher_app/res/colors.dart';
import 'package:publisher_app/res/routes/route_name.dart';

import '../widgets/books_card.dart';

class BookManage extends StatefulWidget {
  const BookManage({super.key});

  @override
  State<BookManage> createState() => _BookManageState();
}

class _BookManageState extends State<BookManage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Novel/Comics',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteName.addBook);
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
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
                    selected: query == '' ? true : false,
                    onSelected: (v) {
                      setState(() {
                        query = '';
                      });
                    },
                    label: const Text('All'),
                  ),
                  FilterChip(
                    selected: query == 'active=true' ? true : false,
                    onSelected: (v) {
                      setState(() {
                        query = 'active=true';
                      });
                    },
                    label: const Text('Active'),
                  ),
                  FilterChip(
                    selected: query == 'active=false' ? true : false,
                    onSelected: (v) {
                      setState(() {
                        query = 'active=false';
                      });
                    },
                    label: const Text('In Active'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: Provider.of<APICalls>(context, listen: false)
                    .getBooks(query),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.data!.isEmpty) {
                      return const Center(
                        child: Text('No document Found'),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChangeNotifierProvider.value(
                          value: snapshot.data!.data![index],
                          child: BookCard(onCallBack: onCallBack),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCallBack() {
    setState(() {});
  }
}
