import 'package:flutter/material.dart';
import '../../view%20Model/firebase_methods.dart';
import '../../view%20Model/local%20storage/local_storage.dart';
import '../../models/publisher_model.dart';

class UserProvider extends ChangeNotifier {
  Publisher? _publisher;
  Publisher? get getPublisher => _publisher;
  Future<void> refreshUser() async {
    Publisher pub = await LocalStorage().getUser();
    Publisher p = await FireBaseMethods().getUserData(pub.id.toString());
    _publisher = p;
    notifyListeners();
  }
}
