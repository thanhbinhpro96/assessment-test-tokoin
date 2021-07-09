import 'package:assessment_test_tokoin/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late User _user = User(
    username: "",
    password: ""
  );

  // Check if user has logged in
  bool checkUser() {
    return _user.username != "";
  }

  // Get current user
  User get getUser => _user;

  // Set current logged in user
  void setUser(Map<String, dynamic> json) {
    _user = User.fromJson(json);
    notifyListeners();
  }

  // Clear current user
  void clearUser() {
    _user = User(
      username: "",
      password: "",
    );
    notifyListeners();
  }
}