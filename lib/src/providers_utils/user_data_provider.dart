import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pryvee/src/models/user.dart';

class UserProvider extends ChangeNotifier {
  UserData userData;
  CollectionReference users;
  FirebaseAuth auth = FirebaseAuth.instance;

  UserProvider() {
    users = FirebaseFirestore.instance.collection('users');
  }

  Future<UserData> initUserData() async {
    print("initializing User Data");
    var documentSnapshot =
        await users.doc(FirebaseAuth.instance.currentUser.email).get();
    if (documentSnapshot != null || documentSnapshot.exists) {
      print("User Data initialized");
      userData = UserData.fromJson(documentSnapshot.data());
      return userData;
    } else {
      debugPrint("Error while initializing user data");
      return null;
    }
  }

  Future<bool> checkUser() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return null;
    }
    await initUserData();
    return true;
  }
}
