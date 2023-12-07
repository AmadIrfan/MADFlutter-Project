import 'package:admin_app/views/drawer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../res/buttons/custom_button.dart';
import '../../res/colors.dart';
import '../../res/text_field/custom_text_field.dart';
import '../data/local services/local_storage.dart';
import '../data/services/api_route.dart';
import '../utils/utils.dart';

class ChangeIpAddress extends StatefulWidget {
  const ChangeIpAddress({super.key});

  @override
  State<ChangeIpAddress> createState() => _ChangeIpAddressState();
}

// change server address screen to change id if of mobile
class _ChangeIpAddressState extends State<ChangeIpAddress> {
  final FocusNode ipNode = FocusNode();
  final FocusNode btnNode = FocusNode();
  String address = '';
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        centerTitle: true,
        title: const Text(
          'Change Ip Address',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: const SizedBox(),
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () async {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                text: 'server name',
                init: url,
                thisNode: ipNode,
                onSubmit: (v) {
                  FocusScope.of(context).requestFocus(btnNode);
                },
                onValidate: (c) {
                  return null;
                },
                onSave: (v) {
                  address = v!;
                },
              ),
              const Gap(20),
              CustomButton(
                isLoading: isLoading,
                focusNode: btnNode,
                text: 'Save Address',
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

  void onSave() async {
    try {
      setState(() {
        isLoading = true;
      });

      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          url = address;
        });
        await Provider.of<LocalStorage>(context, listen: false)
            .setServer(address);
        Utils().showToast('Successfully Updates');
      }
    } catch (e) {
      Utils().showToast(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }
}
