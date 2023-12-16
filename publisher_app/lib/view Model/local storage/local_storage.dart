import 'package:flutter/material.dart';
import 'package:publisher_app/models/publisher_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage with ChangeNotifier {
  Future<bool> setUser(Publisher publisher) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool? res = await sp.setString('publisher', publisher.toJson());
    return res;
  }

  Future<Publisher> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? res = sp.getString('publisher');
    return Publisher.fromJson(res!);
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
