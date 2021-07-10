class User {
  final String username;
  final String password;

  User({required this.username, required this.password});

  // Convert json to user object
  factory User.fromJson(Map<String, dynamic> _json) {
    return User(
      username: _json["username"],
      password: _json["password"]
    );
  }

  // Convert user object to json
  Map<String, dynamic> toJson(User _user) {
    return {
      "username": _user.username,
      "password": _user.password
    };
  }
}