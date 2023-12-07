import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_app/view%20model/local_storage.dart';

import '../models/user_model.dart';

class FireBaseMethods with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadPost(String path, String name, File file) async {
    Reference ref = _storage.ref().child('$path/$name');
    UploadTask uploadTask = ref.putFile(file);
    await Future.value(uploadTask);
    String link = await ref.getDownloadURL();

    return link;
  }

  Future<void> signup(String name, String password, String email) async {
    try {
      UserCredential userData = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel u = UserModel(
        id: userData.user!.uid,
        name: name,
        email: email,
        role: 'user',
        profileImage: '',
        phone: '',
        createDate: DateTime.now(),
        updateDate: DateTime.now(),
      );
      await _firestore.collection('user').doc(userData.user!.uid).set(
            u.toMap(),
          );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(Map<String, String> user) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: user['email']!,
        password: user['password']!,
      );
      UserModel u = await getUserData(_auth.currentUser!.uid);
      await LocalStorage().setUser(u);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserData(String id) async {
    DocumentSnapshot doc = await _firestore.collection('user').doc(id).get();
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  Future<void> updateUserData(UserModel u) async {
    try {
      await _firestore.collection('user').doc(u.id).update(u.toMap());
      UserModel user = await getUserData(_auth.currentUser!.uid);
      await LocalStorage().setUser(user);
    } catch (e) {
      rethrow;
    }
  }
}
