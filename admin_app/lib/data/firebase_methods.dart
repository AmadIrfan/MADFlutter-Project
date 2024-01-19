import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/publisher_model.dart';
import '../models/user_model.dart';
import '../data/local%20services/local_storage.dart';

// this class handle all firebase services
class FireBaseMethods with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// upload picture or files to firebase
  Future<String> uploadPost(String path, String name, File file) async {
    Reference ref = _storage.ref().child('$path/$name');
    UploadTask uploadTask = ref.putFile(file);
    await Future.value(uploadTask);
    String link = await ref.getDownloadURL();
    return link;
  }

// signup functions to register user
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
        role: 'admin',
        profileImage: '',
        phone: '',
        createDate: DateTime.now(),
        updateDate: DateTime.now(),
      );
      await _firestore
          .collection('admin')
          .doc(userData.user!.uid)
          .set({"name": "amad"});
    } catch (e) {
      rethrow;
    }
  }

// reset password
  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
    } catch (e) {
      rethrow;
    }
  }

// register publisher
  Future<void> registerPublisher(
    String name,
    String fatherName,
    String email,
    String password,
    String phone,
    String address,
    String bio,
  ) async {
    try {
      UserCredential pubData = await _auth.createUserWithEmailAndPassword(
        email: email.toString(),
        password: password.toString(),
      );
      Publisher pub = Publisher(
        id: pubData.user!.uid,
        password: '',
        email: email,
        name: name,
        fatherName: fatherName,
        phone: phone,
        profileImage: '',
        gender: '',
        address: address,
        bio: bio,
        createDate: DateTime.now(),
        updateDate: DateTime.now(),
      );
      FirebaseFirestore.instance.collection('admin').doc('afsudhfuhsdufhu').set({'active':true});
      FirebaseFirestore.instance.collection('admin').doc('afsudhfuhsdufhu').update({'active':true});
      FirebaseFirestore.instance.collection('admin').doc('afsudhfuhsdufhu').get();
      FirebaseFirestore.instance.collection('admin').snapshots();
      FirebaseFirestore.instance.collection('admin').doc('afsudhfuhsdufhu').delete();      // await _firestore.collection('publisher').doc(pubData.user!.uid).set(
      //       pub.toMap(),
      //     );
    } catch (e) {
      rethrow;
    }
  }

// login user
  Future<void> login(Map<String, String> user) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: user['email']!,
        password: user['password']!,
      );

      UserModel u = await getUserData(_auth.currentUser!.uid);
      LocalStorage().setUser(u);
    } catch (e) {
      rethrow;
    }
  }

// get single user data based on id
  Future<UserModel> getUserData(String uid) async {
    // User? user = _auth.currentUser;
    DocumentSnapshot doc = await _firestore.collection('admin').doc(uid).get();
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  Future<void> updateStatusInActive(String table, String uid) async {
    await _firestore.collection(table).doc(uid).update({
      'active': false,
    });

    notifyListeners();
  }

// update status of active or inactive of user/publisher /admin
  Future<void> updateStatusActive(
      String table, bool currentStatus, String uid) async {
    if (!currentStatus) {
      await _firestore.collection(table).doc(uid).update({
        'active': true,
      });
    } else {
      await _firestore.collection(table).doc(uid).update({
        'active': false,
      });
    }
    notifyListeners();
  }

//get last 24 hours register user
  Future<int> getUsersRegisteredLast24Hours() async {
    final DateTime now = DateTime.now();
    final DateTime twentyFourHoursAgo = now.subtract(const Duration(days: 1));
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('user')
        .where(
          'registrationTimestamp',
          isGreaterThanOrEqualTo: twentyFourHoursAgo.toString(),
        )
        .get();
    return result.size;
  }

// calculate active or in active user
  Future<Map<String, double>> calculateUserStats(String collectionName) async {
    final CollectionReference usersCollection =
        _firestore.collection(collectionName);
    // Query all users
    QuerySnapshot usersSnapshot = await usersCollection.get();

    // Initialize counters
    double totalUsers = double.parse(usersSnapshot.size.toString());
    double activeUsers = 0;
    double inactiveUsers = 0;

    // Calculate active and inactive users
    for (var userDoc in usersSnapshot.docs) {
      if (userDoc.exists) {
        // Assuming "active" is a boolean field in the document
        bool isActive = userDoc.get('active') ?? false;

        if (isActive) {
          activeUsers++;
        } else {
          inactiveUsers++;
        }
      }
    }

    // Create and return the result map
    Map<String, double> result = {
      'Total': totalUsers,
      'active': activeUsers,
      'inactive': inactiveUsers,
    };
    return result;
  }

// getting last 24 hours register user
  Future<Map<String, double>> calculateNewRegistrations() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('user').get();
    final DateTime now = DateTime.now();
    final DateTime twentyFourHoursAgo = now.subtract(const Duration(hours: 24));
    int count = 0;
    for (var doc in snapshot.docs) {
      // Assuming 'created_at' is the field where the registration date is stored
      final String timestamp = doc['createDate'];
      final DateTime registrationDate = DateTime.parse(timestamp);
      if (registrationDate.isAfter(twentyFourHoursAgo) &&
          registrationDate.isBefore(now)) {
        count++;
      }
    }
    return {'User': count.toDouble()};
  }

  Future<void> updateUserData(UserModel u) async {
    try {
      await _firestore.collection('admin').doc(u.id).update(u.toMap());
      UserModel user = await getUserData(_auth.currentUser!.uid);
      await LocalStorage().setUser(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print(credential);
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);
      UserModel u = UserModel(
        id: user.user!.uid,
        name: user.user!.displayName,
        email: user.user!.email,
        role: 'admin',
        profileImage: user.user!.photoURL,
        phone: '',
        createDate: DateTime.now(),
        updateDate: DateTime.now(),
      );
      await _firestore.collection('admin').doc(user.user!.uid).set(
            u.toMap(),
          );
      LocalStorage().setUser(u);

      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
