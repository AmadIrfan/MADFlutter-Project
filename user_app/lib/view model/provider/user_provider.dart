import 'package:flutter/material.dart';
import 'package:user_app/view%20model/firebase_methods.dart';
import 'package:user_app/view%20model/local_storage.dart';
import 'package:user_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get getUser => _user;

  Future<void> refreshUser() async {
    UserModel u = await LocalStorage().getUser();
    UserModel user = await FireBaseMethods().getUserData(u.id!);
    _user = user;
    notifyListeners();
  }
}
