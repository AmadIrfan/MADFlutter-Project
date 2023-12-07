import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:publisher_app/view%20Model/local%20storage/local_storage.dart';
import 'package:publisher_app/models/publisher_model.dart';

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

  Future<void> updateUserData(Publisher u) async {
    try {
      await _firestore.collection('publisher').doc(u.id).update(u.toMap());
      Publisher user = await getUserData(_auth.currentUser!.uid);
      await LocalStorage().setUser(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(Map<String, String> user) async {
    try {
      UserCredential u = await _auth.signInWithEmailAndPassword(
        email: user['email']!,
        password: user['password']!,
      );
      Publisher pub = await getUserData(u.user!.uid);
      await LocalStorage().setUser(pub);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> forgotPassword(String email) async {}
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<Publisher> getUserData(String id) async {
    DocumentSnapshot doc =
        await _firestore.collection('publisher').doc(id).get();
    return Publisher.fromMap(doc.data() as Map<String, dynamic>);
  }
}
