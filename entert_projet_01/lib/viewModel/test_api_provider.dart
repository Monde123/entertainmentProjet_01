// viewModel/test_api_provider.dart
import 'package:entert_projet_01/model/user_api_model.dart';
import 'package:entert_projet_01/repository/test_api_user.dart';
import 'package:flutter/foundation.dart';



class TestApiProvider with ChangeNotifier {
  List<UserApiPublic> _commitsList = [];
  List<UserApiPublic> get commitsList => _commitsList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final TestApiUserRepository _repository = TestApiUserRepository();

  TestApiProvider() {
    _fetchComments();
  }

  void _fetchComments() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _commitsList = await _repository.fetchCommits();
    } catch (e) {
      _errorMessage = "Impossible de charger les commentaires : $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
