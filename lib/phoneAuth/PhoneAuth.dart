// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_app/authServ/AuthService.dart';
import 'package:flutter_auth_app/common.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  final _formKey = GlobalKey<FormState>();

  final _phonenumController = TextEditingController();
  final _codeController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _phonenumController.dispose();
    _codeController.dispose();
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
                  'Phone Verif',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 120,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phonenumController,
                  decoration: textFieldDeco('Phone Numer'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                   keyboardType: TextInputType.number,
                  controller: _codeController,
                  decoration: textFieldDeco('Code'),
                  validator: (value) {},
                ),
                SizedBox(
                  height: 20,
                ),
                CupertinoButton(
                  color: Colors.blueGrey,
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      _authService.verifyPhoneNum(
                          context, _phonenumController.text.trim());
                    }
                  },
                  child: const Text('Send Code'),
                ),
                SizedBox(height: 10,),
                CupertinoButton(
                  color: Colors.blueGrey,
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      _authService
                          .verifyCodeSentToPhone(_codeController.text.trim());
                    }
                  },
                  child: const Text('Verify Code'),
                ),
              ],
            ),
          ),
        )),
      )),
    );
  }
}
