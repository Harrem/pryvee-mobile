import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pryvee/src/models/user.dart';
import '../models/conversation.dart';
import '../models/message.dart';
import '../models/with_user_data.dart';
import '../utils/notification_services.dart';

class ConversationProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser.uid;
  List<Conversation> conversations = [];
  List<Conv> convs = [];
  Conv currentConv;
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

    convs = docs.docs.map((e) => Conv.fromMap(e.data())).toList();
    // var cids = docs.docs.map((e) => e.data()['cid'] as String).toList();

    // for (var cid in cids) {
    //   docRef = colRef.doc(cid);
    //   var snapshot = await docRef.get();
    //   if (snapshot.exists && snapshot.data() != null) {
    //     debugPrint(snapshot.data().toString());
    //     var conversation = Conversation.fromMap(snapshot.data());
    //     conversations.add(conversation);
    //     debugPrint("conversation initialized!");
    //   }
    // }
  }

  Future<List<Conv>> getConvs() async {
    List<Conv> list = [];
    var docs = await firestore
        .collection('users')
        .doc(uid)
        .collection('conversations')
        .get();
    for (var doc in docs.docs) {
      var a = Conv.fromMap(doc.data());
      list.add(a);
    }
    return list;
  }

  Future<Conversation> createConversation(
      UserData fromUser, Conv withUser) async {
    final docRef = await firestore.collection("conversations").doc();
    String cid = docRef.id;

    var conv = Conversation(
        cid: cid,
        createdDate: DateTime.now(),
        updatedDate: DateTime.now(),
        user1: uid,
        user2: withUser.uid,
        lastMessage: null);

    await docRef.set(conv.toMap());

    // await firestore
    //     .collection('users')
    //     .doc(toUid)
    //     .collection("messageRequests")
    //     .add(wu.toMap());
    var cidmap = {'cid': cid};
    var withUserMap = withUser.toMap();
    withUserMap.addEntries(cidmap.entries);

    var fromUserData = WithUserData.fromMap(fromUser.toMap());
    var fromUserMap = fromUserData.toMap();
    fromUserMap.addEntries(cidmap.entries);
    await firestore
        .collection('users')
        .doc(withUser.uid)
        .collection("conversations")
        .add(fromUserMap);
    await firestore
        .collection('users')
        .doc(uid)
        .collection("conversations")
        .add(withUserMap);
    notifyListeners();
    return conv;
  }

  void sendMessage(String message, String uid, String fullName, String nuid,
      String profileUrl) {
    var msg = Message(
        text: message,
        sentDate: DateTime.now(),
        cid: currentConv.cid,
        fromUid: uid,
        isDelivered: false,
        didRead: false);

    firestore
        .collection("conversations")
        .doc(currentConv.cid)
        .collection('messages')
        .add(msg.toMap())
        .then((value) async {
      await firestore
          .collection("conversations")
          .doc(currentConv.cid)
          .update({'updatedDate': msg.sentDate.millisecondsSinceEpoch});
      await initConv();
      if (nuid != null)
        NotificationServices.sendNotification(
                [nuid], msg.text, fullName, profileUrl)
            .then(
          (response) => debugPrint("Notification sent"),
        );
      debugPrint("message Sent");
    }).catchError((e) => e);
  }

  Future<void> markAsRead() async {
    // currentConv.lastMessage.didRead = true;
  }

  Stream<QuerySnapshot> readMessage1() {
    var res = firestore.collection("messages").orderBy('date').snapshots();
    return res;
  }

  Future<void> updateConversations() async {}

  Stream<List<Conversation>> streamConversation() async* {
    for (var conv in conversations) {
      colRef
          .doc(conv.cid)
          .snapshots()
          .map((map) => Conversation.fromMap(map.data()));
    }
  }

  Stream<List<Message>> readMessage() {
    return firestore
        .collection("conversations")
        .doc(currentConv.cid)
        .collection("messages")
        .orderBy("sentDate", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) {
        return Message.fromMap(e.data());
      }).toList();
    });
  }

  Future<Message> getLastMessage(cid) async {
    if (cid != null) {
      var doc = await FirebaseFirestore.instance
          .collection("conversations")
          .doc(cid)
          .collection("messages")
          .orderBy('sentDate', descending: true)
          .limit(1)
          .get();
      if (doc.docs.isNotEmpty) {
        return Message.fromMap(doc.docs.first.data());
      }
    }
    return null;
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

  void reset() {
    uid = null;
    conversations = null;
    docRef = null;
  }
}
