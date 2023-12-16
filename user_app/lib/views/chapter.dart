import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:user_app/models/chapter_model.dart';
import 'package:user_app/models/novel.dart';
import 'package:user_app/view%20model/services/api_calls.dart';
import '../utils/app_permission.dart';
import '../widget/chapter_card.dart';

class ChapterView extends StatefulWidget {
  const ChapterView({super.key});

  @override
  State<ChapterView> createState() => _ChapterViewState();
}

class _ChapterViewState extends State<ChapterView> {
  Book? book;
  bool init = true;
  @override
  void initState() {
    checkPermission();
    super.initState();
  }

  bool isPermission = false;
  var checkAllPermission = CheckPermissions();

  checkPermission() async {
    var permission = await checkAllPermission.isStoragePermission();
    print('--->$permission');
    if (permission) {
      setState(() {
        isPermission = true;
      });
    }
  }

  @override
  void didChangeDependencies() async {
    if (init) {
      book = ModalRoute.of(context)!.settings.arguments as Book?;
      init = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(book!.name.toString()),
      ),
      body: FutureBuilder(
        future:
            Provider.of<ApiCalls>(context).getChapters(book!.sId.toString()),
        builder:
            (BuildContext context, AsyncSnapshot<ChaptersResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            if (snapshot.data!.data!.isEmpty) {
              return const Center(
                child: Text('No chapter Found'),
              );
            }
            return isPermission
                ? ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChapterCard(
                        chNo: snapshot.data!.data![index].chapterNo.toString(),
                        chName:
                            snapshot.data!.data![index].chapterName.toString(),
                        fileLink: snapshot.data!.data![index].file.toString(),
                        fileRating: book!.novelRating!.length.toString(),
                      );
                    },
                  )
                : Center(
                    child: TextButton(
                      child: const Text('Permission'),
                      onPressed: () {
                        checkPermission();
                      },
                    ),
                  );
          }
        },
      ),
    );
  }
}
