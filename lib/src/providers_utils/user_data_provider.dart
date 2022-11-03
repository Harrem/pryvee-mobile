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

  Future<void> initUserData() async {
    DocumentSnapshot<Object> documentSnapshot = await users.doc().get();
    if (documentSnapshot != null || documentSnapshot.exists) {
      debugPrint("User Data initialized");

      userData = UserData.fromJson(documentSnapshot.data());
    } else {
      debugPrint("Error while initializing user data");
    }
  }
}
