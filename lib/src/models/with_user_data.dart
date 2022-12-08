// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WithUserData {
  String uid;
  String fullName;
  bool isActive;
  String picture;
  WithUserData({
    this.uid,
    this.fullName,
    this.isActive,
    this.picture,
  });

  WithUserData copyWith({
    String uid,
    String fullName,
    bool isActive,
    String profilePictureUrl,
  }) {
    return WithUserData(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      isActive: isActive ?? this.isActive,
      picture: profilePictureUrl ?? this.picture,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fullName': fullName,
      'isActive': isActive,
      'profilePictureUrl': picture,
    };
  }

  factory WithUserData.fromMap(Map<String, dynamic> map) {
    return WithUserData(
      uid: map['uid'] as String,
      fullName: "${map['firstName']} ${map['lastName']}",
      isActive: map['isActive'] as bool,
      picture: map['picture'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WithUserData.fromJson(String source) =>
      WithUserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WithUserData(uid: $uid, fullName: $fullName, isActive: $isActive, profilePictureUrl: $picture)';
  }

  @override
  bool operator ==(covariant WithUserData other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.fullName == fullName &&
        other.isActive == isActive &&
        other.picture == picture;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        fullName.hashCode ^
        isActive.hashCode ^
        picture.hashCode;
  }
}
