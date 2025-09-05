// viewModel/user_provider.dart
import 'package:entert_projet_01/model/user_model.dart';
import 'package:entert_projet_01/repository/auth_repository.dart';

import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? _userModel;
  UserModel? get user => _userModel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isConnected => user != null;

  
  void _isSetting(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  final authReposiry = AuthRepository();

  UserProvider() {
    authReposiry.userState.listen((user) {
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
      final user = await authReposiry.userSign(email: mail, passWord: passWord);
      _userModel = user;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isSetting(false);
    }
  }

  //reauthentification d'un user

  // fin de la réauthentification

  Future<void> updateProfile({
    required String name,
    required String surName,
  }) async {
    final uid = _userModel?.uid;
    if (uid == null) return;

    try {
      await authReposiry.updateProfile(name: name, surName: surName);
      await loadUser(uid);
    } catch (e) {
      _errorMessage = 'Erreur inattendue';
    }
  }

  Future<void> signUp({
    required String mail,
    required String name,
    required String surName,
    required String passWord,
  }) async {
    _isSetting(true);
    _errorMessage = null;
    try {
      final user = await authReposiry.userSignUp(
        mail: mail,
        name: name,
        surName: surName,
        passWord: passWord,
      );
      _userModel = user;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isSetting(false);

      notifyListeners();
    }
  }

  Future<void> loadUser(String uid) async {
    final user = await authReposiry.getUser(uid);
    if (user == null) {
      _errorMessage = 'Données introuvables';
    } else {
      _userModel = user;
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await authReposiry.userSignout();
    _userModel = null;

    notifyListeners();
  }


}
