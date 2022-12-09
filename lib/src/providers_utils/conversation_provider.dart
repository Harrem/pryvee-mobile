import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/conversation.dart';
import '../models/message.dart';
import '../models/with_user_data.dart';

class ConversationProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser.uid;
  List<Conversation> conversations;
  Conversation currentConv;
  DocumentReference docRef;
  CollectionReference colRef =
      FirebaseFirestore.instance.collection('conversations');

  Future<void> initConv() async {
    debugPrint("initializing conversations");
    var docs = await firestore
        .collection('users')
        .doc(uid)
        .collection('conversations')
        .get();
    var cids = docs.docs.map((e) => e.data()).toList();

    for (var cid in cids) {
      docRef = colRef.doc(cid['cid']);
      var snapshot = await docRef.get();
      if (snapshot.exists && snapshot.data() != null) {
        debugPrint(snapshot.data().toString());
        var conversation = Conversation.fromMap(snapshot.data());
        conversations.add(conversation);
        debugPrint("conversation initialized!");
      }
    }
  }

  Future<Conversation> createConversation(String fromUid, String toUid) async {
    final docRef = await firestore.collection("conversations").doc();
    String cid = docRef.id;

    var conv = Conversation(
        cid: cid,
        createdDate: DateTime.now(),
        updatedDate: DateTime.now(),
        user1: fromUid,
        user2: toUid,
        lastMessage: null);

    await docRef.set(conv.toMap());

    // await firestore
    //     .collection('users')
    //     .doc(toUid)
    //     .collection("messageRequests")
    //     .add(wu.toMap());

    await firestore
        .collection('users')
        .doc(toUid)
        .collection("conversations")
        .add({cid: cid});
    await firestore
        .collection('users')
        .doc(fromUid)
        .collection("conversations")
        .add({cid: cid});

    return conv;
  }

  void sendMessage(String message, String cid, String uid) {
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

  Future<void> markAsRead() async {
    currentConv.lastMessage.didRead = true;
  }

  Stream<QuerySnapshot> readMessage1() {
    var res = firestore.collection("messages").orderBy('date').snapshots();
    return res;
  }

  Stream<List<Conversation>> streamConversation() async* {
    for (var conv in conversations) {
      colRef
          .doc(conv.cid)
          .snapshots()
          .map((map) => Conversation.fromMap(map.data()));
    }
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
        return Message.fromMap(e.data());
      }).toList();
    });
  }

  Future<Message> getLastMessage(int index) async {
    var doc = await FirebaseFirestore.instance
        .collection("conversations")
        .doc(conversations[index].cid)
        .collection("messages")
        .orderBy('sentDate', descending: true)
        .limit(1)
        .get();

    return Message.fromMap(doc.docs.first.data());
  }

  Future<WithUserData> getWithUser(String uid) async {
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

  // Future<DocumentReference<WithUserData>> getOtherUser(String otherUid) async {
  //   final model = firestore
  //       .collection('users')
  //       .doc(otherUid)
  //       .withConverter<WithUserData>(
  //           fromFirestore: (snapshot, options) =>
  //               WithUserData.fromMap(snapshot.data()),
  //           toFirestore: (model, _) => model.toMap());

  //   return model;
  // }

  Future<void> syncConversations() async {
    conversations.forEach((element) {
      docRef
          .update(element.toMap())
          .then((value) => debugPrint("Conversations synced"));
    });
  }
}
