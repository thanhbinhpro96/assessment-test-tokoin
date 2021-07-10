import 'package:assessment_test_tokoin/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class RegisterBottomSheet extends StatefulWidget {
  
  const RegisterBottomSheet({ Key? key}) : super(key: key);

  @override
  State createState() => _RegisterBottomSheetState();
}

class _RegisterBottomSheetState extends StateMVC<RegisterBottomSheet> {

  _RegisterBottomSheetState() : super(ProfileController()) {
    con = controller as ProfileController;
  }
  late ProfileController con;
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    ThemeData _theme = Theme.of(context);
    return SizedBox(
      width: _size.width,
      height: _size.height*0.8,
      child: BottomSheet(
        onClosing: () => Navigator.pop(context),
        enableDrag: false,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _registerFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("REGISTER", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 30),
                    // Username field
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: "Username"
                      ),
                      controller: _usernameField,
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return "Field cannot be left empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Password field
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: "Password",
                      ),
                      controller: _passwordField,
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return "Field cannot be left empty";
                        }
                        if(value.trim().length < 8) {
                          return "Password length must be greater than 8";
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    MaterialButton(
                      child: Text("Register", style: TextStyle(color: _theme.colorScheme.onPrimary)),
                      color: _theme.primaryColor,
                      onPressed: () {
                        if(_registerFormKey.currentState!.validate()) {
                          con.register(context, _usernameField.text, _passwordField.text);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}