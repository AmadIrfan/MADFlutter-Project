import 'package:admin_app/data/local%20services/local_storage.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../firebase_methods.dart';

// when user login this class help to get data from firebase and set locally and also when user data change on firebase
class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get getUser => _user;
// major function to get and set user details
  Future<void> refreshUser() async {
    UserModel u = await LocalStorage().getUser();
    UserModel user = await FireBaseMethods().getUserData(u.id.toString());
    _user = user;

    notifyListeners();
  }
}
