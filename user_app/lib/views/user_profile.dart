import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/routes/route_name.dart';
import 'package:user_app/view%20model/provider/user_provider.dart';
import 'package:user_app/views/drawer.dart';
import 'package:user_app/widget/custum_tile.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    user.refreshUser();
    final u = user.getUser;
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          u!.name.toString(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(RouteName.updateScreen, arguments: u);
              setState(() {});
            },
            icon: const Icon(Icons.edit),
            tooltip: 'Edit User Details',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: Colors.black,
                  border: Border.all(width: 2),
                  shape: BoxShape.circle,
                ),
                child: u.profileImage!.isEmpty
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'assets/images/PhUserBold.svg',
                          fit: BoxFit.contain,
                          height: 100,
                          color: Colors.black,
                        ),
                      )
                    : CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                          u.profileImage.toString(),
                          // fit: BoxFit.cover,
                          // color: Colors.black,
                        ),
                      ),
              ),
              const Gap(10),
              CustomTile(
                title: 'Name',
                value: u.name.toString(),
              ),
              CustomTile(
                title: 'Email',
                value: u.email!,
              ),
              CustomTile(
                title: 'Phone No',
                value: u.phone.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
