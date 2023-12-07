// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:publisher_app/view%20Model/services/api_calls.dart';
import 'package:publisher_app/view%20Model/firebase_methods.dart';
import 'package:publisher_app/models/author_response.dart';
import 'package:publisher_app/res/colors.dart';
import 'package:publisher_app/res/text_field/custom_text_field.dart';
import '../view Model/provider/user_provider.dart';
import '../utils/utils.dart';

class AddChapters extends StatefulWidget {
  const AddChapters({super.key});

  @override
  State<AddChapters> createState() => _AddChaptersState();
}

class _AddChaptersState extends State<AddChapters> {
  bool isLoading = false;
  final _key = GlobalKey<FormState>();
  final nameNode = FocusNode();
  final chNoNode = FocusNode();
  final btn1Node = FocusNode();
  final btn2Node = FocusNode();
  List<File> images = [];
  final TextStyle txtStyle = const TextStyle(
    fontWeight: FontWeight.w800,
  );
  bool init = true;
  @override
  void dispose() {
    nameNode.dispose();
    chNoNode.dispose();
    btn1Node.dispose();
    btn2Node.dispose();
    super.dispose();
  }

  File? _file;
  Map<String, dynamic> _data = {
    'chapterName': '',
    'chapterNo': 0,
    'file': '',
    'bookId': '',
    'active': true,
    'rating': [],
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final id = ModalRoute.of(context)!.settings.arguments;

    _data = {
      'chapterName': _data['chapterName']!,
      'chapterNo': _data['chapterNo'],
      'file': _data['file']!,
      'bookId': id,
      'active': _data['active']!,
      'rating': _data['rating']!,
    };
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: darkBlueColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: darkBlueColor,
        centerTitle: true,
        title: const Text(
          'Add New Chapter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        actions: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : IconButton(
                  onPressed: () {
                    onSave();
                  },
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      text: 'Enter Chapter name ',
                      thisNode: nameNode,
                      onSubmit: (v) {
                        FocusScope.of(context).requestFocus(chNoNode);
                      },
                      onValidate: (v) {
                        if (v!.isEmpty) {
                          return 'enter a valid name';
                        }
                        return null;
                      },
                      onSave: (v) {
                        _data = {
                          'chapterName': v!,
                          'chapterNo': _data['chapterNo']!,
                          'file': _data['file']!,
                          'bookId': _data['bookId']!,
                          'active': _data['active']!,
                          'rating': _data['rating']!,
                        };
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.027,
                    ),
                    CustomTextField(
                      textInputType: TextInputType.number,
                      text: 'Enter Chapter No ',
                      thisNode: chNoNode,
                      onSubmit: (v) {
                        FocusScope.of(context).requestFocus(btn1Node);
                      },
                      onValidate: (v) {
                        if (v!.isEmpty) {
                          return 'enter a valid No';
                        } else if (int.parse(v) < 0) {
                          return 'enter a Positive No';
                        }
                        return null;
                      },
                      onSave: (v) {
                        _data = {
                          'chapterName': _data['chapterName']!,
                          'chapterNo': int.parse(v!),
                          'file': _data['file']!,
                          'bookId': _data['bookId']!,
                          'active': _data['active']!,
                          'rating': _data['rating']!,
                        };
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.027,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                _file == null
                                    ? 'Select file'
                                    : path.basename(_file!.path.toString()),
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: const TextStyle(),
                              ),
                            ),
                          ),
                          IconButton(
                            visualDensity:
                                VisualDensity.adaptivePlatformDensity,
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: false,
                                type: FileType.custom,
                                allowedExtensions: [
                                  'pdf',
                                  'docx',
                                ],
                              );
                              if (result != null) {
                                File file = File(result.files[0].path!);
                                setState(() {
                                  _file = File(file.path);
                                });
                              } else {
                                // User canceled the picker
                              }
                            },
                            icon: const Icon(
                              Icons.upload_file,
                              color: darkBlueColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.027,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSave() async {
    UserProvider up = Provider.of<UserProvider>(context, listen: false);
    up.refreshUser();
    try {
      if (_key.currentState!.validate()) {
        if (_file == null) {
          Utils().showToast('file is not selected');
          return;
        } else {
          setState(() {
            isLoading = true;
          });
          _key.currentState!.save();
          String name = path.basename(_file!.path);
          String filePath =
              await Provider.of<FireBaseMethods>(context, listen: false)
                  .uploadPost('books/${up.getPublisher!.id}', name, _file!);
          _data['file'] = filePath;
          AuthorResponse ar =
              await Provider.of<APICalls>(context, listen: false)
                  .uploadChapters(_data);

          Utils().showToast(ar.message);
          // if ('bv ' != null) {
          // } else {
          // Utils().showToast("ar.message");
          // }
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Utils().showToast(
        e.toString(),
      );
    }
  }
}
