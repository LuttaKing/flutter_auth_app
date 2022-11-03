// ignore_for_file: prefer_const_constructors

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_app/authServ/AuthService.dart';
import 'package:flutter_auth_app/common.dart';

class EmailLinkAuthPage extends StatefulWidget {
  const EmailLinkAuthPage({super.key});

  @override
  State<EmailLinkAuthPage> createState() => _EmailLinkAuthPageState();
}

class _EmailLinkAuthPageState extends State<EmailLinkAuthPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
         
    super.didChangeDependencies();
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
                  'Send Magic Link',
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
                    //  if (_formKey.currentState!.validate()) {
                    final _status = _authService.sendMagicLink(
                      context,
                      '111mullerfred11@gmail.com',

                      //    _emailController.text.trim(),
                    );
                    //    }
                  },
                  child: const Text('Send Link'),
                ),
              ],
            ),
          ),
        )),
      )),
    );
  }
}
