import 'package:admin_app/data/services/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../res/buttons/custom_button.dart';
import '../res/text_field/custom_text_field.dart';
import '../utils/utils.dart';

class SendEmailPage extends StatefulWidget {
  const SendEmailPage({super.key});

  @override
  State<SendEmailPage> createState() => _SendEmailPageState();
}

// screen use for email sending on admin dashboard
class _SendEmailPageState extends State<SendEmailPage> {
  bool isLoading = false;
  final FocusNode _email = FocusNode();
  final FocusNode _title = FocusNode();
  final FocusNode _body = FocusNode();
  final FocusNode _btn = FocusNode();
  final _key = GlobalKey<FormState>();
  Map<String, dynamic> _data = {
    'email': '',
    'subject': '',
    'body': '',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Email'),
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  text: 'Email',
                  thisNode: _email,
                  onSubmit: (v) {
                    FocusScope.of(context).requestFocus(_title);
                  },
                  onValidate: (v) {
                    if (v!.isEmpty) {
                      return 'Email field is empty';
                    } else if (!isValidEmail(v)) {
                      return 'enter valid email';
                    }
                    return null;
                  },
                  onSave: (v) {
                    _data = {
                      'email': v,
                      'subject': _data['subject'],
                      'body': _data['body'],
                    };
                  },
                ),
                const Gap(20),
                CustomTextField(
                  text: 'tile',
                  thisNode: _title,
                  onSubmit: (v) {
                    FocusScope.of(context).requestFocus(_body);
                  },
                  onValidate: (v) {
                    if (v!.isEmpty) {
                      return 'Empty field';
                    }
                    return null;
                  },
                  onSave: (v) {
                    _data = {
                      'email': _data['email'],
                      'subject': v,
                      'body': _data['body'],
                    };
                  },
                ),
                const Gap(20),
                CustomTextField(
                  text: 'body Text',
                  thisNode: _body,
                  lines: 10,
                  onSubmit: (v) {
                    FocusScope.of(context).requestFocus(_btn);
                  },
                  onValidate: (v) {
                    if (v!.isEmpty) {
                      return 'Empty field';
                    }
                    return null;
                  },
                  onSave: (v) {
                    _data = {
                      'email': _data['email'],
                      'subject': _data['subject'],
                      'body': v,
                    };
                  },
                ),
                const Gap(20),
                CustomButton(
                    focusNode: _btn,
                    isLoading: isLoading,
                    text: 'Send Email',
                    onClick: () {
                      onSave();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    );

    bool result = emailRegExp.hasMatch(email);
    return result;
  }

  void onSave() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (_key.currentState!.validate()) {
        _key.currentState!.save();
        await Provider.of<APICalls>(context, listen: false).sendEmail(_data);
        Utils().showToast('Email Sent');
      }
    } catch (e) {
      Utils().showToast(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }
}
