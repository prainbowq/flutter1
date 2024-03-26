class Password {
  const Password({
    required this.name,
    required this.email,
    required this.username,
    required this.password,
    this.id,
  });

  Password.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        email = map['email']!,
        name = map['name']!,
        username = map['username']!,
        password = map['password']!;

  final int? id;
  final String email;
  final String name;
  final String username;
  final String password;

  Map<String, Object?> toMap() => {
        'id': id,
        'email': email,
        'name': name,
        'username': username,
        'password': password,
      };

  static const createSql = 'CREATE TABLE passwords('
      'id INTEGER PRIMARY KEY,'
      'email TEXT,'
      'name TEXT,'
      'username TEXT,'
      'password TEXT)';
}
