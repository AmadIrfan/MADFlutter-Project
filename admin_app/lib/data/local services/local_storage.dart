import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';

class LocalStorage with ChangeNotifier {
  Future<UserModel> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? res = sharedPreferences.getString('adminItem');
    return UserModel.fromJson(res!);
  }

  Future<bool> setUser(UserModel u) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool res = await sharedPreferences.setString('adminItem', u.toJson());
    bool res1 = await sharedPreferences.remove('adminItem');
    
    return res;
  }

  // Future<bool> setServer(String address) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   bool res = await sharedPreferences.setString('server', address);
  //   return res;
  // }

  // Future<String?> getServer() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? res = sharedPreferences.getString('server');
  //   return res;
  // }
}
