import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pryvee/src/models/post.dart';

class PostProvider extends ChangeNotifier {
  List<Post> posts;
  List<Post> livePosts;
  String uid;

  Future<void> fetchAllPostes(String uid) async {
    this.uid = uid;
    debugPrint("fetching posts");
    final querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .doc(uid)
        .collection('posts')
        .get();

    final docs = querySnapshot.docs;
    final list = docs.map((e) => Post.fromJson(e.data())).toList();
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    posts = list;
    livePosts = getLivePosts(list);
  }

  Future<void> makeNewPost(Post post, File profilePic) async {
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
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(uid)
          .collection('posts')
          .doc(doc.id)
          .update({'pid': doc.id});

      final path = doc.path.substring(6);
      if (profilePic != null) {
        String picUrl = await uploadDatingUserPhoto(profilePic, path);
        debugPrint("$picUrl");
        doc.update({'pictureUrl': picUrl});
      }
    } on FirebaseException catch (e) {
      debugPrint(e.code);
    } catch (e) {
      debugPrint("$e");
    }
    notifyListeners();
  }

  Future<String> uploadDatingUserPhoto(File file, String path) async {
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

  List<Post> getLivePosts(List<Post> list) {
    List<Post> livePosts = [];
    posts.forEach((post) {
      if (post.isLive) {
        livePosts.add(post);
      }
    });
    return livePosts;
  }

  Post getPost(int nid) {
    Post p;
    livePosts.forEach((element) {
      if (element.notificationId == nid) {
        p = element;
      }
    });
    return p;
  }

  Future<void> forwardInfo(Post post) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(post.trustedUid)
        .update({'inbox': 'I need your help ASAP!'});
  }

  Future<void> deletePost(Post post) async {
    await FirebaseFirestore.instance
        .collection('tempPostKeeper')
        .doc(uid)
        .collection('posts')
        .doc(post.pid)
        .set(post.toMap())
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(uid)
          .collection('posts')
          .doc(post.pid)
          .delete()
          .then((value) => debugPrint("Post Deleted Successfully!"))
          .catchError((e) => debugPrint("Error: $e"));
    });
    notifyListeners();
    await AwesomeNotifications().cancel(post.notificationId);
  }
}
