import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/buttons/custom_button.dart';
import 'package:user_app/res/colors.dart';
import 'package:user_app/res/text_field/custom_text_field.dart';
import 'package:user_app/view%20model/local_storage.dart';
import 'package:user_app/view%20model/services/routes.dart';

import '../utils/utils.dart';

class ChangeIpAddress extends StatefulWidget {
  const ChangeIpAddress({super.key});

  @override
  State<ChangeIpAddress> createState() => _ChangeIpAddressState();
}

class _ChangeIpAddressState extends State<ChangeIpAddress> {
  final FocusNode ipNode = FocusNode();
  final FocusNode btnNode = FocusNode();
  String address = '';
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        centerTitle: true,
        title: const Text(
          'Change Ip Address',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                text: 'server name',
                init: api,
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
          api = address;
        });
        print(api);
        print(address);
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
