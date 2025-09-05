// repository/auth_repository.dart
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entert_projet_01/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _usersDb = FirebaseFirestore.instance;

  Stream<User?> get userState => _auth.authStateChanges();

  Future<UserModel?> userSign({
    required String email,
    required String passWord,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: passWord,
      );
      return await _loadUser(result.user!.uid);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    } catch (e) {
      throw Exception('Erreur inattendue');
    }
  }

  Future userSignUp({
    required String mail,
    required String name,
    required String surName,
    required String passWord,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: mail,
        password: passWord,
      );
      final userId = result.user!.uid;
      final displayName = '$name $surName';
      final userMap = ({
        'uid': userId,
        'mail': mail,
        'displayName': displayName,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await _usersDb.collection('Users').doc(userId).set(userMap);
      print('user created');
      return UserModel.fromMap({...userMap, 'uid': userId});
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapFirebaseError(e));
    } catch (e) {
      throw Exception('Erreur innatendue');
    }
  }

  Future<UserModel?> _loadUser(String uid) async {
    final doc = await _usersDb.collection('Users').doc(uid).get();
    if (doc.exists == false) {
      throw Exception('Document inexistant');
    }
    if (doc.exists && doc.data() != null) {
      final userData = doc.data();
      return UserModel.fromMap({
        'uid': uid,
        'displayName': userData?['displayName'],
        'mail': userData?['mail'],
      });
    } else {
      return null;
    }
  }

  Future<UserModel?> getUser(String uid) async {
    return await _loadUser(uid);
  }

  Future<void> userSignout() async {
    await _auth.signOut();
  }

  Future<void> updateProfile({
    required String name,
    required String surName,
  }) async {
    try {
      final user = _auth.currentUser;
      final db = _usersDb.collection('Users').doc(user?.uid);
      final displayName = '$name $surName';
      if (user != null) {
        await user.updateDisplayName(displayName);
        await db.update({'displayName': displayName});
      }
    } on FirebaseException {
      throw Exception('Erreur de chargement');
    } catch (e) {
      throw Exception('Erreur innatendue');
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    if (e.code == 'user-not-found') {
      return "aucun utilisateur trouvé avec cet mail";
    }

    if (e.code == 'weak-password') {
      return ('Ce mot de passe est trop faible.');
    } else if (e.code == 'email-already-in-use') {
      return ('Cet email existe déjà.');
    }
    return e.message ?? "Erreur d'authentification";
  }
}
