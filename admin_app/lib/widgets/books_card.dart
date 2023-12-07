import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/author_response.dart';
import '../models/book.dart';
import '../res/routes/route_name.dart';
import '../utils/utils.dart';
import '../data/services/api_calls.dart';

// book card to show book
class BookCard extends StatefulWidget {
  const BookCard({
    required this.onCallBack,
    super.key,
  });
  final Function onCallBack;
  @override
  State<BookCard> createState() => BookCardState();
}

class BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    final BookValue d = Provider.of<BookValue>(context);
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, RouteName.viewBook, arguments: d);
        },
        leading: const CircleAvatar(),
        title: Text(d.name.toString()),
        subtitle: Text(d.author.toString()),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(d.active! ? 'In Active' : 'Active'),
              onTap: () async {
                try {
                  if (d.active!) {
                    AuthorResponse ar =
                        await Provider.of<APICalls>(context, listen: false)
                            .bookStatusChange(false, d.sId!);
                    Utils().showToast(ar.message.toString());
                  } else {
                    AuthorResponse ar =
                        await Provider.of<APICalls>(context, listen: false)
                            .bookStatusChange(true, d.sId!);
                    Utils().showToast(ar.message.toString());
                  }
                  widget.onCallBack();
                } catch (e) {
                  Utils().showToast(e.toString());
                }
              },
            ),
            PopupMenuItem(
              child: Text(d.isContinue! ? 'Discontinue' : 'Continue'),
              onTap: () async {
                try {
                  if (d.isContinue!) {
                    AuthorResponse ar =
                        await Provider.of<APICalls>(context, listen: false)
                            .bookContinueStatusChange(false, d.sId!);
                    Utils().showToast(ar.message.toString());
                  } else {
                    AuthorResponse ar =
                        await Provider.of<APICalls>(context, listen: false)
                            .bookContinueStatusChange(true, d.sId!);
                    Utils().showToast(ar.message.toString());
                  }
                  widget.onCallBack();
                } catch (e) {
                  Utils().showToast(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
