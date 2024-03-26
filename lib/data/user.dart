class User {
  const User({
    required this.email,
    required this.password,
    required this.hint,
    this.length = 14,
    this.uppercase = true,
    this.lowercase = true,
    this.numbers = true,
    this.special = false,
  });

  User.fromMap(Map<String, dynamic> map)
      : email = map['email']!,
        password = map['password']!,
        hint = map['hint']!,
        length = map['length']!,
        uppercase = map['uppercase']! == 1,
        lowercase = map['lowercase']! == 1,
        numbers = map['numbers']! == 1,
        special = map['special']! == 1;

  final String email;
  final String password;
  final String hint;
  final int length;
  final bool uppercase;
  final bool lowercase;
  final bool numbers;
  final bool special;

  Map<String, Object?> toMap() => {
        'email': email,
        'password': password,
        'hint': hint,
        'length': length,
        'uppercase': uppercase ? 1 : 0,
        'lowercase': lowercase ? 1 : 0,
        'numbers': numbers ? 1 : 0,
        'special': special ? 1 : 0,
      };

  static const createSql = 'CREATE TABLE users('
      'email TEXT,'
      'password TEXT,'
      'hint TEXT,'
      'length INTEGER,'
      'uppercase INTEGER,'
      'lowercase INTEGER,'
      'numbers INTEGER,'
      'special INTEGER)';
}
