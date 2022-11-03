import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_app/HomePage.dart';
import 'package:flutter_auth_app/email+pass/LoginPage.dart';
import 'package:flutter_auth_app/email+pass/RegisterPage.dart';

class EmailPasswordAuthPage extends StatefulWidget {
  const EmailPasswordAuthPage({super.key});

  @override
  State<EmailPasswordAuthPage> createState() => _EmailPasswordAuthPageState();
}

class _EmailPasswordAuthPageState extends State<EmailPasswordAuthPage> {
  bool showLogin = true;

  void toggleScreens() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
        //    print('DATA=======: ${snapshot.data}');
            if (snapshot.hasData) {
              return HomePage();
            } else {
              if (showLogin) {
                return LoginPage(toggles: toggleScreens,);
              } else {
                return RegisterPage(toggles: toggleScreens,);
              }
            }
          })),
    );
  }
}
