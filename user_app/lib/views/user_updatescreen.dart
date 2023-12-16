// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:user_app/models/user_model.dart';
import 'package:user_app/res/buttons/custom_button.dart';
import 'package:user_app/res/colors.dart';
import 'package:user_app/res/text_field/custom_text_field.dart';
import 'package:user_app/utils/utils.dart';
import 'package:user_app/view%20model/firebase_methods.dart';
import 'package:path/path.dart' as path;

class UserUpdateScreen extends StatefulWidget {
  const UserUpdateScreen({
    super.key,
  });
  @override
  State<UserUpdateScreen> createState() => _UserUpdateScreenState();
}

class _UserUpdateScreenState extends State<UserUpdateScreen> {
  bool isLoading = false;
  UserModel? user;
  bool init = false;
  final _key = GlobalKey<FormState>();
  final nameNode = FocusNode();
  final emailNode = FocusNode();
  final phoneNode = FocusNode();
  final btn1Node = FocusNode();
  File? image;
  final TextStyle txtStyle = const TextStyle(
    fontWeight: FontWeight.w800,
  );
  @override
  void dispose() {
    nameNode.dispose();
    emailNode.dispose();
    btn1Node.dispose();
    phoneNode.dispose();
    super.dispose();
  }

  String imgP = '';

  @override
  void didChangeDependencies() {
    if (!init) {
      user = ModalRoute.of(context)!.settings.arguments as UserModel?;
      init = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        centerTitle: true,
        title: Text(
          user!.name!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    child: image == null
                        ? user!.profileImage!.isEmpty
                            ? Container(
                                height: 150,
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/PhUserBold.svg',
                                  fit: BoxFit.contain,
                                  height: 100,
                                  color: Colors.white,
                                ),
                              )
                            : Center(
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(
                                    user!.profileImage.toString(),
                                  ),
                                ),
                              )
                        : Center(
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: FileImage(
                                image!,
                                scale: 1.5,
                              ),
                            ),
                          ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 128,
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera,
                          color: Colors.blue,
                        ),
                        onPressed: () async {
                          final imgP = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (imgP != null) {
                            setState(() {
                              image = File(imgP.path);
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              CustomTextField(
                readOnly: false,
                init: user!.name.toString(),
                text: 'Name',
                thisNode: nameNode,
                onSubmit: (v) {
                  FocusScope.of(context).requestFocus(emailNode);
                },
                onValidate: (v) {
                  if (v!.isEmpty) {
                    return 'Enter name';
                  }
                  return null;
                },
                onSave: (v) {
                  user = UserModel(
                    id: user!.id,
                    name: v,
                    phone: user!.phone,
                    email: user!.email,
                    createDate: user!.createDate,
                    role: user!.role,
                    updateDate: DateTime.now(),
                    active: user!.active,
                    isSuperAdmin: user!.isSuperAdmin,
                    profileImage: user!.profileImage,
                  );
                },
              ),
              const Gap(20),
              CustomTextField(
                readOnly: true,
                text: 'email',
                init: user!.email.toString(),
                thisNode: emailNode,
                onSubmit: (v) {
                  FocusScope.of(context).requestFocus(phoneNode);
                },
                onValidate: (v) {
                  return null;
                },
                onSave: (v) {
                  user = UserModel(
                    id: user!.id,
                    name: user!.name!,
                    phone: user!.phone,
                    email: user!.email,
                    createDate: user!.createDate,
                    role: user!.role,
                    updateDate: DateTime.now(),
                    active: user!.active,
                    isSuperAdmin: user!.isSuperAdmin,
                    profileImage: user!.profileImage,
                  );
                },
              ),
              const Gap(20),
              CustomTextField(
                init: user!.phone.toString(),
                text: 'phone Number',
                thisNode: phoneNode,
                textInputType: TextInputType.phone,
                onSubmit: (v) {
                  FocusScope.of(context).requestFocus(btn1Node);
                },
                onValidate: (v) {
                  if (v!.isEmpty) {
                    return 'Enter Phone no';
                  } else if (isValidMobileNumber(v)) {
                    return 'Enter valid 13 character Phone no';
                  } else {
                    return null;
                  }
                },
                onSave: (v) {
                  user = UserModel(
                    id: user!.id,
                    name: user!.name,
                    phone: v,
                    email: user!.email,
                    createDate: user!.createDate,
                    role: user!.role,
                    updateDate: DateTime.now(),
                    active: user!.active,
                    isSuperAdmin: user!.isSuperAdmin,
                    profileImage: user!.profileImage,
                  );
                },
              ),
              const Gap(20),
              CustomButton(
                isLoading: isLoading,
                text: 'update',
                onClick: () {
                  onSave();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSave() async {
    try {
      if (_key.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        _key.currentState!.save();
        if (image != null) {
          String name = path.basename(image!.path);
          final imgPath =
              await Provider.of<FireBaseMethods>(context, listen: false)
                  .uploadPost('ProfileImage/${user!.id}', name, image!);
          setState(() {
            imgP = imgPath;
          });
        } else {
          setState(() {
            imgP = user!.profileImage!;
          });
        }
        user = UserModel(
          id: user!.id,
          name: user!.name,
          phone: user!.phone,
          email: user!.email,
          createDate: user!.createDate,
          role: user!.role,
          updateDate: DateTime.now(),
          active: user!.active,
          isSuperAdmin: user!.isSuperAdmin,
          profileImage: imgP,
        );
        await Provider.of<FireBaseMethods>(context, listen: false)
            .updateUserData(user!);
        Utils().showToast('updated');
      }
    } catch (e) {
      Utils().showToast(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  bool isValidMobileNumber(String input) {
    final RegExp pakistaniNumberRegex = RegExp(r'^923\d{10}$');
    return pakistaniNumberRegex.hasMatch(input);
  }
}
