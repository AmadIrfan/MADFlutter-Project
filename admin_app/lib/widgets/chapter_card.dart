import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';
import '../models/chapter_response.dart';
import '../data/services/api_calls.dart';

class ChapterCard extends StatelessWidget {
  const ChapterCard({super.key, required this.onClick, required this.chapter});
  final Function onClick;
  final Chapter chapter;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: Image.asset(
          'assets/images/Group.png',
          color: Colors.blue,
        ),
        title: Text(chapter.chapterName.toString()),
        subtitle: Text(chapter.chapterName.toString()),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            // PopupMenuItem(
            //   child: const Text('Edit'),
            //   onTap: () {},
            // ),
            PopupMenuItem(
              child: Text(chapter.active! ? 'In Active' : 'Active'),
              onTap: () async {
                try {
                  if (chapter.active!) {
                    await Provider.of<APICalls>(context, listen: false)
                        .chapterStatusChange(false, chapter.id!);
                    Utils().showToast('Successfully Inactivated ');
                  } else {
                    await Provider.of<APICalls>(context, listen: false)
                        .chapterStatusChange(true, chapter.id!);
                    Utils().showToast('Successfully activated');
                  }
                  onClick();
                } catch (e) {
                  Utils().showToast(e.toString());
                }
              },
            ),
            // PopupMenuItem(
            //   child: const Text('Remove'),
            //   onTap: () async {
            //     try {} catch (e) {
            //       Utils().showToast(e.toString());
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
