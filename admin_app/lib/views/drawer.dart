// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';

import '../res/colors.dart';
import '../res/list_tile.dart';
import '../data/provider/user_provider.dart';
import '../res/routes/route_name.dart';
import '../utils/utils.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

//  this screen is use to Navigate to other pages
class _MyDrawerState extends State<MyDrawer> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(
      context,
    );

    return SafeArea(
      child: Drawer(
        width: double.infinity,
        backgroundColor: darkBlueColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              ListTile(
                leading: userProvider.getUser!.profileImage.toString().isEmpty
                    ? CircleAvatar(
                        radius: 30,
                        child: SvgPicture.asset(
                          'assets/images/PhUserBold.svg',
                        ),
                      )
                    : CircleAvatar(
                        radius: 30,
                        // backgroundColor: Colors.green,
                        backgroundImage: NetworkImage(
                          userProvider.getUser!.profileImage.toString(),
                        ),
                      ),
                title: Text(
                  userProvider.getUser!.name.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0.11,
                    letterSpacing: -0.15,
                  ),
                ),
                subtitle: Text(
                  userProvider.getUser!.email.toString(),
                  style: const TextStyle(
                    color: Color(0xFFD1D3D4),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0.08,
                    letterSpacing: -0.12,
                  ),
                ),
                trailing: Builder(
                  builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).closeDrawer();
                    },
                    icon: const Icon(
                      size: 40,
                      Icons.close,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              AppListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    RouteName.home,
                  );
                },
                title: 'Dashboard',
              ),
              AppListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.books,
                  );
                },
                title: 'Books',
              ),
              AppListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.userManage,
                  );
                },
                title: 'Users',
              ),
              AppListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.publisherManage,
                  );
                },
                title: 'Publishers',
              ),
              AppListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.staffManage,
                  );
                },
                title: 'Staff Members',
              ),
              AppListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.email,
                  );
                },
                title: 'Email',
              ),
              AppListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.profile,
                  );
                },
                title: 'Edit Profile',
              ),
              // AppListTile(
              //   onTap: () {
              //     Navigator.pushNamed(
              //       context,
              //       RouteName.ipChange,
              //     );
              //   },
              //   title: 'Change Server Address',
              // ),
              AppListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Utils().showToast('SignOut successfully');
                  Navigator.pushReplacementNamed(
                    context,
                    RouteName.start,
                  );
                },
                title: 'SignOut',
              ),
              const Spacer(),
              Container(
                width: 265,
                height: 50,
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.all(5),
                decoration: ShapeDecoration(
                  color: const Color(0xFF14161A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(2),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: index == 0
                              ? const Color(0xFF29303C)
                              : const Color(0xFF14161A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            index = 0;
                            setState(() {});
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.light_mode,
                                color: Colors.white,
                              ),
                              Gap(5),
                              Text(
                                'Light',
                                style: TextStyle(
                                  color: Color(0xFFD1D3D4),
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 0.11,
                                  letterSpacing: -0.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(2),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: index == 1
                              ? const Color(0xFF29303C)
                              : const Color(0xFF14161A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(
                              () {
                                index = 1;
                              },
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.dark_mode_outlined,
                                color: Colors.white,
                              ),
                              Gap(5),
                              Text(
                                'Dark',
                                style: TextStyle(
                                  color: Color(0xFFD1D3D4),
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 0.11,
                                  letterSpacing: -0.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
