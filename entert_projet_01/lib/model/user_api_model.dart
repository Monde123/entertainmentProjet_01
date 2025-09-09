// model/user_api_model.dart
class UserApiPublic {
  String name;
  String commits;

  UserApiPublic({
    required this.name,
    required this.commits,
  });

  factory UserApiPublic.fromMap(Map<String, dynamic> v) {
    return UserApiPublic(
      name: v['user']?['username'] ?? 'Inconnu',
      commits: v['body'] ?? '',
    );
  }
}
