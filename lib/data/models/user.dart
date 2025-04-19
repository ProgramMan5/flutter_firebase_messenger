class User {
  final String name;

  final String id;

  factory User.fromMap(String id, Map<String, dynamic> data) {
    return User(
      name: data['name'] as String,
      id: id,
    );
  }

  User({required this.name, required this.id});
}
