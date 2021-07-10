import 'package:assessment_test_tokoin/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ControllerMVC {
  factory ProfileController([StateMVC? state]) => _this ??= ProfileController._(state);
  ProfileController._(StateMVC? state) : super(state);
  static ProfileController? _this;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Login action
  void login(context, username, password) async {
    UserProvider _provider = Provider.of<UserProvider>(context, listen: false);
    _prefs.then((SharedPreferences prefs) {
      // Check if credentials exist
      if(!prefs.containsKey("users") || prefs.getStringList("users")!.isEmpty) {
        Fluttertoast.showToast(
          msg: "Credentials are incorrect!",
          backgroundColor: Colors.red,
          textColor: Theme.of(context).colorScheme.onPrimary
        );
      } else {
        List<String>? _userList = prefs.getStringList("users");
        if(_userList!.contains("$username - $password")) {
          Fluttertoast.showToast(
            msg: "Successfully logged in!",
          );
          _provider.setUser({
            "username": username,
            "password": password
          });
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(
            msg: "Credentials are incorrect!",
            backgroundColor: Colors.red,
            textColor: Theme.of(context).colorScheme.onPrimary
          );
        }
      }
    });
  }  

  // Register action
  void register(context, username, password) async {
    UserProvider _provider = Provider.of<UserProvider>(context, listen: false);
    _prefs.then((SharedPreferences prefs) {
      // Check if credentials exist
      if(!prefs.containsKey("users") || prefs.getStringList("users")!.isEmpty) {
        prefs.setStringList("users", ["$username - $password"]);
        _provider.setUser({
          "username": username,
          "password": password
        });
        Fluttertoast.showToast(
          msg: "Account successfully registered! Logging you in...",
        );
        Navigator.pop(context);
      } else {
        List<String>? _userList = prefs.getStringList("users");
        List<String>? _usernameList = [];
        // Get username list from local storage to check if the entered username has already taken.
        for (var _user in _userList!) {
          _usernameList.add(_user.split(" - ").first);
        }
        // If account has already existed, please login
        if(_usernameList.contains(username)) {
          Fluttertoast.showToast(
            msg: "Account has already existed. Please login!",
          );
        } else {
          // If account is not existed, create a new record an save to local storage
          _userList.add("$username - $password");
          prefs.setStringList("users", _userList);
          _provider.setUser({
            "username": username,
            "password": password
          });
          Fluttertoast.showToast(
            msg: "Account successfully registered! Logging you in...",
          );
          Navigator.pop(context);
        }
      }
    });
  }  
}
