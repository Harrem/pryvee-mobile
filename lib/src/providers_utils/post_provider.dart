import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pryvee/src/models/post.dart';

class PostOperations {
  static Future<List<Post>> fetchAllPostes(String uid) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .doc(uid)
        .collection('posts')
        .get();

    final docs = querySnapshot.docs;
    final posts = docs.map((e) => Post.fromJson(e.data())).toList();
    return posts;
  }

  static Future<void> makeNewPost(
      String uid, Post post, File profilePic) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('posts')
          .doc(uid)
          .collection('posts')
          .add(post.toMap())
          .then((value) {
        debugPrint("documentCreated");
        return value;
      });

      final path = doc.path.substring(6);
      if (profilePic != null) {
        String picUrl = await uploadDatingUserPhoto(profilePic, path);
        debugPrint("$picUrl");
        doc.update({'profile': picUrl});
      }
    } on FirebaseException catch (e) {
      debugPrint(e.code);
    } catch (e) {
      debugPrint("$e");
    }
  }

  static Future<String> uploadDatingUserPhoto(File file, String path) async {
    String url;
    final ref = FirebaseStorage.instance.ref("$path/dtUserProPic.jpg");
    await ref.putFile(file).then((p0) async {
      if (p0.state == TaskState.success) {
        url = await ref.getDownloadURL();
        debugPrint("Dating user picture uploaded");
        return url;
      }
    }).onError((error, stackTrace) => Future.error(error));

    return url;
  }
}
