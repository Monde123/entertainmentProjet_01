// providers/user_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entert_projet_01/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? _userModel;
  UserModel? get user => _userModel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isConnected => user != null;
  void _isSetting(bool v) {
    _isLoading = v;
  }

  UserProvider() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        loadUser(user.uid);
      } else {
        _userModel = null;
        notifyListeners();
      }
    });
  }

  Future<void> login(String mail, String passWord) async {
    _isSetting(true);
    _errorMessage = null;
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: mail,
        password: passWord,
      );

      await loadUser(cred.user!.uid);
    } on FirebaseAuthException catch (e) {
      _errorMessage = _mapFirebaseError(e);
    } catch (e) {
      _errorMessage = 'Erreur inattendue';
    } finally {
      _isSetting(false);
    }
  }

  //reauthentification d'un user

  Future<void> _reOauth({required email, required passWord}) async {
    final credential = EmailAuthProvider.credential(
      email: email,
      password: passWord,
    );
    final user = _auth.currentUser;
    if (user == null) {
      'aucun utilisateur connecté';
    }

    try {
      await user!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      'erreur inattendue ${e.message}';
    } catch (e) {
      'Erreur innatendue';
    }
  } // fin de la réauthentification

  Future<void> updateProfile({
    required String name,
    required String surName,
  }) async {
    final user = _auth.currentUser;
    final db = FirebaseFirestore.instance.collection('Users').doc(user!.uid);
    final displayName = '$name $surName';

    try {
      await user.updateDisplayName(displayName);
      await db.update({'displayName': displayName});
    } on FirebaseAuthException catch (e) {
      _errorMessage = _mapFirebaseError(e);
    } catch (e) {
      _errorMessage = 'Erreur inattendue';
    } finally {
      notifyListeners();
    }
  }

  Future<void> signIn({
    required String mail,
    required String name,
    required String surName,
    required String passWord,
  }) async {
    _isSetting(true);
    _errorMessage = null;
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: mail,
        password: passWord,
      );
      final uid = cred.user!.uid;
      final displayName = '$name $surName';
      final userMap = ({
        'uid': uid,
        'mail': mail,
        'displayName': displayName,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await _db.collection('Users').doc(uid).set(userMap);
      print('users crée avec succès');
      _userModel = UserModel.fromMap({...userMap, 'uid': uid});
    } on FirebaseAuthException catch (e) {
      _errorMessage = _mapFirebaseError(e);
    } catch (e) {
      _errorMessage = 'Erreur inattendue';
    } finally {
      _isSetting(false);

      notifyListeners();
    }
  }

  Future<void> loadUser(String uid) async {
    final doc = await _db.collection('Users').doc(uid).get();
    if (doc.exists && doc.data() != null) {
      final userData = doc.data()!;
      _userModel = UserModel.fromMap({
        'uid': uid,
        'displayName': userData['displayName'],
        'mail': userData['mail'],
      });
    } else {
      _errorMessage = 'Données introuvables';
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _userModel = null;

    notifyListeners();
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
