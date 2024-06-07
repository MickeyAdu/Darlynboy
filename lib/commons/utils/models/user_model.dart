import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String fullName;
  final String email;

  // final String badgeNumber;
  final String uid;
  UserModel({
    required this.fullName,
    required this.email,
    // required this.badgeNumber,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      // 'badgeNumber': badgeNumber,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      // badgeNumber: map['badgeNumber'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
