// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_app/authServ/AuthService.dart';
import 'package:flutter_auth_app/common.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({super.key});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

    final AuthService _authService = AuthService();


  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(),
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
                  'Reset Password',
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
                      return 'Please enter email';
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
                    
                    final _status = _authService.resetPasswordwEmailLink(
                          context,_emailController.text.trim(),
                          );

                      
                    }
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),
        )),
      )),
    );
  }

 
}
