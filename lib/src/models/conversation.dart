import 'dart:convert';

class Conversation {
  String cid;
  DateTime createdDate;
  String docRef;
  String user1;
  String user2;

  Conversation({
    this.cid,
    this.createdDate,
    this.docRef,
    this.user1,
    this.user2,
  });

  Conversation copyWith({
    String cid,
    DateTime createdDate,
    String docRef,
    String user1,
    String user2,
  }) {
    return Conversation(
      cid: cid ?? this.cid,
      createdDate: createdDate ?? this.createdDate,
      docRef: docRef ?? this.docRef,
      user1: user1 ?? this.user1,
      user2: user2 ?? this.user2,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cid': cid,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'docRef': docRef,
      'user1': user1,
      'user2': user2,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      cid: map['cid'] as String,
      createdDate:
          DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int),
      docRef: map['docRef'] != null ? map['docRef'] as String : null,
      user1: map['user1'] as String,
      user2: map['user2'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversation.fromJson(String source) =>
      Conversation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Conversation(cid: $cid, createdDate: $createdDate, docRef: $docRef, user1: $user1, user2: $user2)';
  }

  @override
  bool operator ==(covariant Conversation other) {
    if (identical(this, other)) return true;

    return other.cid == cid &&
        other.createdDate == createdDate &&
        other.docRef == docRef &&
        other.user1 == user1 &&
        other.user2 == user2;
  }

  @override
  int get hashCode {
    return cid.hashCode ^
        createdDate.hashCode ^
        docRef.hashCode ^
        user1.hashCode ^
        user2.hashCode;
  }
}
