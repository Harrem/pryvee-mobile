import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';
import '../models/with_user_data.dart';

class CloudStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void writeMessage(String message, String cid, String uid) {
    var msg = Message(
        text: message,
        sentDate: DateTime.now(),
        cid: cid,
        fromUid: uid,
        isDelivered: false,
        didRead: false);

    firestore
        .collection("conversations")
        .doc(cid)
        .collection('messages')
        .add(msg.toMap())
        .then((value) => debugPrint("message Sent"))
        .catchError((e) => e);
  }

  Stream<List<Message>> readMessage(String cid) {
    return firestore
        .collection("conversations")
        .doc(cid)
        .collection("messages")
        .orderBy("sentDate", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) {
        debugPrint("sdkfjlsdjfs");
        return Message.fromMap(e.data());
      }).toList();
    });
  }

  static Future<WithUserData> getWithUser(String uid) async {
    var doc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    var withUser;
    if (doc.exists) {
      withUser = WithUserData.fromMap(doc.data());
    } else {
      debugPrint("With User Not Found");
    }
    return withUser;
  }
}
