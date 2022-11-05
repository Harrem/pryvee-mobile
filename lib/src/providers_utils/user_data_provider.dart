import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pryvee/src/models/user.dart';

class UserProvider extends ChangeNotifier {
  UserData userData;
  CollectionReference users;
  String uid;
  FirebaseAuth auth = FirebaseAuth.instance;

  UserProvider() {
    if (auth.currentUser != null) uid = auth.currentUser.uid;
    users = FirebaseFirestore.instance.collection('users');
  }

  Future<UserData> initUserData() async {
    print("Uid: $uid");
    print("initializing User Data");
    var documentSnapshot = await users.doc(uid).get();
    if (documentSnapshot != null || documentSnapshot.exists) {
      userData = UserData.fromJson(documentSnapshot.data());
      print(userData.firstName);
      debugPrint(userData.toJson());
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

  Future<void> updateEmail(String email) async {
    await auth.currentUser.updateEmail(email).then((value) async {
      await users.doc(uid).update({'email': email}).onError(
          (error, stackTrace) => Future.error(error));
    }).onError((error, stackTrace) => Future.error(error));
    ;
  }

  Future<void> updatePassword(String password) async {
    await auth.currentUser
        .updatePassword(password)
        .then((value) => debugPrint("Password Updated successfully"))
        .catchError((e) => Future.error(e));
  }

  Future<UserData> editUserInfoAPI(
      {String maritalStatus,
      String email,
      String firstName,
      String lastName,
      String picture,
      String gender}) async {
    Map<String, String> map = {
      'maritalStatus': maritalStatus,
      'firstName': firstName,
      'lastName': lastName,
      'picture': picture,
      'gender': gender,
    };
    await users.doc(uid).update(map);
    final doc = await users.doc(uid).get();
    return UserData.fromJson(doc.data());
  }

  Future<String> updateProfilePicAPI(File file) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    final proPicRef = storage.ref('$uid/profilePic/proPic.jpg');
    String url;
    await proPicRef.putFile(file).then((p0) async {
      if (p0.state == TaskState.success) {
        url = await proPicRef.getDownloadURL();
        userData.picture = url;
        debugPrint(uid);
        await updateUserData();
        debugPrint("Profile Picture updated successfully");
      } else if (p0.state == TaskState.running) {
        debugPrint('Uploading Profile Picture');
      } else {
        debugPrint("Error while uploading Profile Picture");
        return Future.error("Error while uploading picture");
      }
    });
    notifyListeners();
    debugPrint(url);
    return url;
  }

  Future<void> updateUserData() async {
    users.doc(auth.currentUser.uid).update(userData.toMap());
  }
}
