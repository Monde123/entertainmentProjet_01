// repository/test_api_user.dart


import 'dart:convert';
import 'package:entert_projet_01/model/user_api_model.dart';
import 'package:http/http.dart';

class TestApiUserRepository {
  Future<List<UserApiPublic>> fetchCommits() async {
    var url = Uri.parse("https://dummyjson.com/comments?limit=10");
    var response = await get(url);

    if (response.statusCode == 200) {
      final map = jsonDecode(response.body) as Map<String, dynamic>;
      final list = map['comments'] as List<dynamic>;

      return list.map((v) => UserApiPublic.fromMap(v)).toList();
    } else {
      throw Exception('Erreur de récupération des commentaires');
    }
  }
}
