
// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_app/LoginPage.dart';
import 'package:flutter_auth_app/common.dart';

class RegisterPage extends StatefulWidget {
    final VoidCallback toggles;

  const RegisterPage({super.key, required this.toggles});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

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
                  'Register',
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
                  height: 20,
                ),
                CupertinoButton(
                  color: Colors.blueGrey,
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid,
                      showSnackx(context, 'message');
                      signUp();
                    }
                  },
                  child: const Text('Register'),
                ),

                  CupertinoButton(
                  onPressed: widget.toggles,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        )),
      )),
    );
  }

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text.trim());
       
  }
}
