import 'dart:convert';

import 'package:pryvee/src/models/message.dart';

class Conversation {
  String cid;
  DateTime createdDate;
  DateTime updatedDate;
  String docRef;
  String user1;
  String user2;
  Message lastMessage;

  Conversation(
      {this.cid,
      this.createdDate,
      this.updatedDate,
      this.docRef,
      this.user1,
      this.user2,
      this.lastMessage});

  Conversation copyWith(
      {String cid,
      DateTime createdDate,
      DateTime updatedDate,
      String docRef,
      String user1,
      String user2,
      Message lastMessage}) {
    return Conversation(
      cid: cid ?? this.cid,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      docRef: docRef ?? this.docRef,
      user1: user1 ?? this.user1,
      user2: user2 ?? this.user2,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cid': cid,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'updatedDate': updatedDate.millisecondsSinceEpoch,
      'docRef': docRef,
      'user1': user1,
      'user2': user2,
      'lastMessage': lastMessage,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
        cid: map['cid'] as String,
        createdDate:
            DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int),
        updatedDate: (map['updatedDate'] == null)
            ? DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int)
            : DateTime.fromMillisecondsSinceEpoch(map['updatedDate'] as int),
        docRef: map['docRef'] != null ? map['docRef'] as String : null,
        user1: map['user1'] as String,
        user2: map['user2'] as String,
        lastMessage: (map['lastMessage'] == null)
            ? null
            : Message.fromMap((map['lastMessage'] as Map<String, dynamic>)));
  }

  String toJson() => json.encode(toMap());

  factory Conversation.fromJson(String source) =>
      Conversation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Conversation(cid: $cid, createdDate: $createdDate, updatedDate: $updatedDate, docRef: $docRef, user1: $user1, user2: $user2, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(covariant Conversation other) {
    if (identical(this, other)) return true;

    return other.cid == cid &&
        other.createdDate == createdDate &&
        other.updatedDate == updatedDate &&
        other.docRef == docRef &&
        other.user1 == user1 &&
        other.user2 == user2 &&
        other.lastMessage == lastMessage;
  }

  @override
  int get hashCode {
    return cid.hashCode ^
        createdDate.hashCode ^
        updatedDate.hashCode ^
        docRef.hashCode ^
        user1.hashCode ^
        user2.hashCode ^
        lastMessage.hashCode;
  }
}
