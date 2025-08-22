// model/user_model.dart

import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  UserModel({required this.mail, required this.uid, required this.displayName});
  final String uid;
  final String displayName;
  final String mail;
  factory UserModel.fromMap(Map<String, dynamic> m) {
    return UserModel(
      mail: m['mail'],
      uid: m['uid'],
      displayName: m['displayName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'mail': mail, 'uid': uid, 'displayName': displayName};
  }
}
