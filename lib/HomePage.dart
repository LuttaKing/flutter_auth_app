import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_app/common.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    if (user!.emailVerified) {
      print('Verified');
    } else {
      user!.sendEmailVerification();
            print('Not Verified,Email Sent');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
              ),
              Text('Home'),
              Text('Signed in as: ${user!.email}'),
              SizedBox(
                height: 20,
              ),
              
              CupertinoButton(
                color: Colors.blueGrey,
                onPressed: () {
                  // If the form is valid,
                  showSnackx(context, 'message');
                  signOut();
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
