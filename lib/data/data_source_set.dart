import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pryvee/src/providers_utils/auth_provider.dart';
import 'package:pryvee/src/utils/cloudinary_client/models/CloudinaryResponse.dart';
import 'package:pryvee/src/utils/cloudinary_client/cloudinary_client.dart';
import 'package:pryvee/src/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pryvee/data/data_source_local.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/src/models/post.dart';
import 'package:pryvee/src/models/user.dart';
import 'dart:io';

class DataSourceSet {
  CloudinaryClient cloudinaryClient = CloudinaryClient(
      PRYVEE_CLOUDINARY_API_KEY, PRYVEE_CLOUDINARY_SECRET_KEY, "pryvee");
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference post = FirebaseFirestore.instance.collection('posts');
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

  Future<CloudinaryResponse> uploadImageToCloudinary(
      File file, String folder, String filename) async {
    CloudinaryResponse cloudinaryResponse = await cloudinaryClient.uploadImage(
        file.path,
        filename: '${filename}_TIMESTAMP_$timestamp',
        folder: folder);
    return (cloudinaryResponse == null) ? null : cloudinaryResponse;
  }

  Future<CloudinaryResponse> uploadVideoToCloudinary(
      File file, String folder, String filename) async {
    CloudinaryResponse cloudinaryResponse = await cloudinaryClient.uploadVideo(
        file.path,
        filename: '${filename}_TIMESTAMP_$timestamp',
        folder: folder);
    return (cloudinaryResponse == null) ? null : cloudinaryResponse;
  }

  Future<User> loginAPI(String email, String password) async {
    var user = await AuthProvider()
        .signInWithEmailAndPassword(email: email, password: password);

    if (user != null) {
      return user;
    } else {
      return null;
    }
    // DocumentSnapshot<Object> documentSnapshot = await users.doc(email).get();
    // if (documentSnapshot == null || documentSnapshot.exists == false)
    //   return null;
    // else
    //   return User.fromJson(documentSnapshot.data());
  }

  Future<void> forgotPasswordAPI(email) async {
    await AuthProvider()
        .forgotPassword(email: email)
        .onError((error, stackTrace) => Future.error(error))
        .catchError((e) {
      debugPrint(e);
      return Future.error(e);
    });
  }

  Future<User> registerAPI(
      String email, String firstName, String lastName, String password) async {
    final auth = AuthProvider();
    var user =
        await auth.signUpWithEmailAndPassword(email: email, password: password);
    user.updateDisplayName("$firstName $lastName");
    UserData userData = UserData(
      uid: user.uid,
      nuid: await getOneSignalUserId(),
      email: email,
      firstName: firstName,
      lastName: lastName,
      createdAt: DateTime.now().toIso8601String(),
      picture: DEFAULT_USER_PICTURE,
      conversations: [],
      contacts: [],
    );

    await users.doc(user.uid).set(userData.toMap());

    if (user != null)
      return user;
    else
      return null;
  }

  Future<void> deleteCurrentUserAPI() async =>
      await users.doc(await getLocalUserIdFromSP()).delete();

  Future<UserData> updateCurrentUserAPI(String maritalStatus, String email,
      String firstName, String lastName, String picture, String gender) async {
    Map<String, String> map = {
      'maritalStatus': maritalStatus,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'picture': picture,
      'gender': gender,
    };
    await users.doc(email).set(map);
    return UserData.fromJson(map);
  }

  Future<String> updateProfilePicAPI({File file, String uid}) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    final proPicRef = storage.ref('$uid/profilePic/proPic.jpg');
    String url;

    await proPicRef.putFile(file).then((p0) async {
      if (p0.state == TaskState.success) {
        debugPrint("Profile Picture updated successfully");
        url = await proPicRef.getDownloadURL();
      } else if (p0.state == TaskState.running) {
        debugPrint('Uploading Profile Picture');
      } else {
        debugPrint("Error while uploading Profile Picture");
        return Future.error("Error while uploading picture");
      }
    });
    debugPrint(url);
    return url;
  }

  Future<Post> addNewPostAPI(
    AddressModel datingAddress,
    String currentUserEmail,
    String carPlateNumber,
    DateTime dateTime,
    int checkInterval,
    String trustedUserEmail,
    String transport,
    UserData datingUser,
  ) async {
    Map<String, dynamic> map = {
      'datingAddress': {
        "postCode": datingAddress.postCode,
        "address": datingAddress.address,
        "country": datingAddress.country,
        "city": datingAddress.city,
      },
      "currentUserEmail": await getLocalEmailFromSP(),
      'checkInterval': checkInterval.toString(),
      'trustedUserEmail': trustedUserEmail,
      'carPlateNumber': carPlateNumber,
      'dateTime': dateTime.toString(),
      'transport': transport,
      'datingUser': {
        'firstName': datingUser.firstName,
        'lastName': datingUser.lastName,
        'picture': datingUser.picture,
        'gender': datingUser.gender,
        'phone': datingUser.phone,
      },
    };
    await post.doc(await getLocalEmailFromSP()).collection('objects').add(map);
    return Post.fromJson(map);
  }
}
