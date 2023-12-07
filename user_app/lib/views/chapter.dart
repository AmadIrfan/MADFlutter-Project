import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:user_app/models/chapter_model.dart';
import 'package:user_app/models/novel.dart';
import 'package:user_app/view%20model/services/api_calls.dart';

class ChapterView extends StatefulWidget {
  const ChapterView({super.key});

  @override
  State<ChapterView> createState() => _ChapterViewState();
}

class _ChapterViewState extends State<ChapterView> {
  Book? book;
  @override
  void initState() {
    getDataModelRoute();
    super.initState();
  }

  bool init = true;
  void getDataModelRoute() {}

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
            return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (BuildContext context, int index) {
                // print(snapshot.data!.data![index].file);
                return ChapterCard(
                  chNo: snapshot.data!.data![index].chapterNo.toString(),
                  chName: snapshot.data!.data![index].chapterName.toString(),
                  fileLink: snapshot.data!.data![index].file.toString(),
                  fileRating: book!.novelRating!.length.toString(),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ChapterCard extends StatefulWidget {
  const ChapterCard(
      {super.key,
      required this.chNo,
      required this.chName,
      required this.fileLink,
      required this.fileRating});
  final String chNo;
  final String chName;
  final String fileLink;
  final String fileRating;

  @override
  State<ChapterCard> createState() => _ChapterCardState();
}

class _ChapterCardState extends State<ChapterCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          CircleAvatar(
            child: Text(widget.chNo),
          ),
          Gap(20),
          Column(
            children: [
              Text(widget.chName),
              Text(
                "rating ${widget.fileRating}/5.0",
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.download,
                ),
              ),
              IconButton(
                onPressed: () {},
                tooltip: 'Read online',
                icon: const Icon(
                  Icons.book_online,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> downloadFile(String link) async {
    final dir = await getTemporaryDirectory();
    await Dio().download(
      link,
      "${dir.path}/${widget.chName}/$link",
    );
  }
}


  // double calculateAverageRating(List<Rating> ratings) {
  //   if (ratings.isEmpty) {
  //     return 0.0;
  //   }

  //   double totalRating = 0.0;
  //   int ratedCount = 0;

  //   for (var rating in ratings) {
  //     if (rating.active!) {
  //       totalRating += rating.rating!;
  //       ratedCount++;
  //     }
  //   }
  //   if (ratedCount == 0) {
  //     return 0.0;
  //   }

  //   return totalRating / ratedCount;
  // }

