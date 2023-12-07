import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/models/novel.dart';
import 'package:user_app/view%20model/services/api_calls.dart';

class ViewChapter extends StatefulWidget {
  const ViewChapter({super.key, required this.book});
  final Book book;
  @override
  State<ViewChapter> createState() => _ViewChapterState();
}

class _ViewChapterState extends State<ViewChapter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.name.toString()),
      ),
      body: FutureBuilder(
        future: Provider.of<ApiCalls>(context, listen: false)
            .getChapters(widget.book.sId.toString()),
        builder: (BuildContext context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Text(
                  snapshot.data!.data![index].chapterNo.toString(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
