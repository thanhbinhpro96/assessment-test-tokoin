import 'package:assessment_test_tokoin/controllers/profile_controller.dart';
import 'package:assessment_test_tokoin/providers/user_provider.dart';
import 'package:assessment_test_tokoin/widgets/login_sheet.dart';
import 'package:assessment_test_tokoin/widgets/register_sheet.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends StateMVC<ProfilePage> {

  _ProfilePageState() : super(ProfileController()) {
    con = controller as ProfileController;
  }
  late ProfileController con;

  @override
  Widget build(BuildContext context) {
    UserProvider _provider = Provider.of<UserProvider>(context);
    ThemeData _theme = Theme.of(context);
    return Center(
      child: !_provider.checkUser() ?
        // If user not logged in, show login prompt button
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Login button
            MaterialButton(
              child: Text("Log in", style: TextStyle(color: _theme.colorScheme.onPrimary)),
              color: _theme.primaryColor,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const LoginBottomSheet(),
                );
              },
            ),
            const SizedBox(height: 16),
            // Register button
            MaterialButton(
              child: Text("Register", style: TextStyle(color: _theme.colorScheme.onPrimary)),
              color: _theme.primaryColor,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const RegisterBottomSheet(),
                );
              },
            )
          ],
        ) :
        // If user has logged in, show profile
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome back, ${_provider.getUser.username}"),
            const SizedBox(height: 16),
            MaterialButton(
              child: Text("Logout", style: TextStyle(color: _theme.colorScheme.onPrimary)),
              color: _theme.primaryColor,
              onPressed: () {
                _provider.clearUser();
              },
            )
          ],
        )
    );
  }
}