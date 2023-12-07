import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../data/firebase_methods.dart';
import '../utils/utils.dart';
import '../res/routes/route_name.dart';

// user card shows user in list
class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.userModel});

  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    final updateStatus = Provider.of<FireBaseMethods>(context, listen: false);
    return Card(
      color: const Color(0xFFD9D9D9),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteName.viewDetailed,
            arguments: userModel,
          );
        },
        leading: userModel.profileImage.toString().isEmpty
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
                  userModel.profileImage.toString(),
                ),
              ),
        title: Text(
          userModel.name.toString(),
          style: const TextStyle(
            color: Color(0xFF171B36),
            fontSize: 20,
            height: 0,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          userModel.email.toString(),
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
              child: Text(bool.parse(userModel.active.toString())
                  ? 'In Active'
                  : 'Active'),
              onTap: () async {
                await updateStatus.updateStatusActive(
                    'user',
                    bool.parse(userModel.active.toString()),
                    userModel.id.toString());
                Utils().showToast(bool.parse(userModel.active.toString())
                    ? 'user InActivate'
                    : 'user Activate');
              },
            ),
          ],
        ),
      ),
    );
  }
}
