// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Message {
  String text;
  DateTime sentDate;
  String cid;
  String fromUid;
  bool isDelivered;
  bool didRead;
  String type;

  Message({
    this.text,
    this.sentDate,
    this.cid,
    this.fromUid,
    this.isDelivered,
    this.didRead,
    this.type,
  });

  Message copyWith({
    String text,
    DateTime sentDate,
    String cid,
    String fromUid,
    bool isDelivered,
    bool didRead,
  }) {
    return Message(
      text: text ?? this.text,
      sentDate: sentDate ?? this.sentDate,
      cid: cid ?? this.cid,
      fromUid: fromUid ?? this.fromUid,
      isDelivered: isDelivered ?? this.isDelivered,
      didRead: didRead ?? this.didRead,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'sentDate': sentDate.millisecondsSinceEpoch,
      'cid': cid,
      'fromUid': fromUid,
      'isDelivered': isDelivered,
      'didRead': didRead,
      'type': type,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'] as String,
      sentDate: DateTime.fromMillisecondsSinceEpoch(map['sentDate'] as int),
      cid: map['cid'] as String,
      fromUid: map['fromUid'] as String,
      isDelivered: map['isDelivered'] as bool,
      didRead: map['didRead'] as bool,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(text: $text, sentDate: $sentDate, cid: $cid, fromUid: $fromUid, isDelivered: $isDelivered, didRead: $didRead)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.sentDate == sentDate &&
        other.cid == cid &&
        other.fromUid == fromUid &&
        other.isDelivered == isDelivered &&
        other.didRead == didRead;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        sentDate.hashCode ^
        cid.hashCode ^
        fromUid.hashCode ^
        isDelivered.hashCode ^
        didRead.hashCode;
  }
}
