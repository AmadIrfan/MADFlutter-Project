import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:path/path.dart' as path;
import 'package:user_app/res/colors.dart';
import 'package:open_file/open_file.dart';
import 'package:user_app/utils/directory_path.dart';
import 'package:user_app/utils/utils.dart';

class ChapterCard extends StatefulWidget {
  const ChapterCard({
    super.key,
    required this.chNo,
    required this.chName,
    required this.fileLink,
    required this.fileRating,
  });
  final String chNo;
  final String chName;
  final String fileLink;
  final String fileRating;

  @override
  State<ChapterCard> createState() => _ChapterCardState();
}

class _ChapterCardState extends State<ChapterCard> {
  bool downloading = false;
  bool fileExist = false;
  late String filePath;
  String fileName = '';
  double progress = 0.0;
  late CancelToken cancelToken;

  var getPathFile = DirectoryPath();
  @override
  void initState() {
    super.initState();
    setState(() {
      fileName = path.basename(widget.fileLink);
    });
    checkFileExist();
  }

  myOpenFile(String filePath) async {
    await OpenFile.open(filePath);
  }

  cancelDownload() async {
    debugPrint('called');
    cancelToken.cancel();
    setState(() {
      downloading = false;
    });
  }

  startDownload() async {
    cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    try {
      downloading = true;
      Utils().showToast('downloading started');
      await Dio().download(
        widget.fileLink,
        filePath,
        onReceiveProgress: (count, total) {
          setState(() {
            progress = (count / total);
          });
        },
        cancelToken: cancelToken,
      );
      setState(() {
        downloading = false;
        fileExist = true;
      });
      Utils().showToast('downloading Completed');
    } catch (e) {
      Utils().showToast(e.toString());
      setState(() {
        downloading = false;
      });
    }
  }

  checkFileExist() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      fileExist = fileExistCheck;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          CircleAvatar(
            child: Text(widget.chNo),
          ),
          const Gap(20),
          Column(
            children: [
              Text(widget.chName),
              // Text(
              //   "rating ${widget.fileRating}/5.0",
              // ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  fileExist && downloading == false
                      ? Utils().showToast('file already Exist')
                      : startDownload();
                },
                icon: fileExist
                    ? const Icon(
                        Icons.download_done,
                      )
                    : downloading
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator.adaptive(
                                value: progress,
                                strokeWidth: 3,
                                backgroundColor: Colors.grey,
                                valueColor:
                                    const AlwaysStoppedAnimation(darkBlueColor),
                              ),
                              Text(
                                (progress * 100).toStringAsFixed(2),
                              ),
                            ],
                          )
                        : const Icon(
                            Icons.download,
                          ),
              ),
              fileExist && downloading == false
                  ? IconButton(
                      onPressed: () {
                        fileExist && downloading == false
                            ? myOpenFile(filePath)
                            : cancelDownload();
                      },
                      tooltip: 'Read online',
                      icon: const Icon(
                        Icons.window,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
