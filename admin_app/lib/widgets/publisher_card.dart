import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../res/routes/route_name.dart';
import '../data/firebase_methods.dart';
import '../models/publisher_model.dart';
import '../utils/utils.dart';

// publisher card to show publisher
class PublisherCard extends StatelessWidget {
  const PublisherCard({super.key, required this.pModel});

  final Publisher pModel;

  @override
  Widget build(BuildContext context) {
    final updateStatus = Provider.of<FireBaseMethods>(context, listen: false);

    return Card(
      color: const Color(0xFFD9D9D9),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteName.publisherView,
            arguments: pModel,
          );
        },
        leading: pModel.profileImage.toString().isEmpty
            ? CircleAvatar(
                radius: 30,
                child: SvgPicture.asset(
                  'assets/images/PhUserBold.svg',
                ),
              )
            : CircleAvatar(
                radius: 30,
                backgroundColor: Colors.amber,
                backgroundImage: NetworkImage(
                  pModel.profileImage.toString(),
                ),
              ),
        title: Text(
          pModel.name.toString(),
          style: const TextStyle(
            color: Color(0xFF171B36),
            fontSize: 20,
            height: 0,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          pModel.email.toString(),
          style: const TextStyle(
            color: Color(0xFF171B36),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 0,
            fontFamily: 'Inter',
          ),
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(bool.parse(pModel.active.toString())
                  ? 'In Active'
                  : 'Active'),
              onTap: () async {
                await updateStatus.updateStatusActive('publisher',
                    bool.parse(pModel.active.toString()), pModel.id.toString());
                Utils().showToast(bool.parse(pModel.active.toString())
                    ? 'publisher InActivate'
                    : 'publisher Activate');
              },
            ),
          ],
        ),
      ),
    );
  }
}
