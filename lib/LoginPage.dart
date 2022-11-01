// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_app/ChangePass.dart';
import 'package:flutter_auth_app/authServ/AuthService.dart';
import 'package:flutter_auth_app/common.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback toggles;
  const LoginPage({super.key, required this.toggles});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Login',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 120,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: textFieldDeco('Email'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@') ||
                        value.length < 7) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passController,
                  decoration: textFieldDeco('Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Please enter valid password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                CupertinoButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangePass()),
                    );
                  },
                  child: const Text('Forgot Pass'),
                ),
                SizedBox(
                  height: 20,
                ),
                CupertinoButton(
                  color: Colors.blueGrey,
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      final _status = _authService.signinwEmailandPass(
                          context,_emailController.text.trim(),
                          _passController.text.trim(),);
                    }
                  },
                  child: const Text('Login'),
                ),
                CupertinoButton(
                  onPressed: widget.toggles,
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        )),
      )),
    );
  }
}
