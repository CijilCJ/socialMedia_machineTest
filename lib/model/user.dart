class User {
  final String username;
  final String email;
  final String password;

  User({required this.username, required this.email, required this.password});

  Map<String, dynamic> toMap() => {
    'username': username,
    'email': email,
    'password': password,
  };

  factory User.fromMap(Map<String, dynamic> map) => User(
    username: map['username'],
    email: map['email'],
    password: map['password'],
  );
}
