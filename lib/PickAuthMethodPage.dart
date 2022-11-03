import 'package:flutter/material.dart';
import 'package:flutter_auth_app/email+pass/Email_auth_main_page.dart';
import 'package:flutter_auth_app/email_link/EmailLInkAuthPage.dart';
import 'package:flutter_auth_app/google_auth/google_authPag.dart';
import 'package:flutter_auth_app/phoneAuth/PhoneAuth.dart';

class PickAuthMethod extends StatefulWidget {
  const PickAuthMethod({super.key});

  @override
  State<PickAuthMethod> createState() => _PickAuthMethodState();
}

class _PickAuthMethodState extends State<PickAuthMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height:80),
              OutlinedButton.icon(
                  onPressed: () {
                    goTo(const PhonePage());
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text('Phone Auth')),


SizedBox(height: 40,),

                  OutlinedButton.icon(
                  onPressed: () {
                    goTo(const EmailPasswordAuthPage());
                  },
                  icon: const Icon(Icons.email_outlined),
                  label: const Text('Email + Password')),

SizedBox(height: 40,),
                    OutlinedButton.icon(
                  onPressed: () {
                    goTo(const EmailLinkAuthPage());
                  },
                  icon: const Icon(Icons.alternate_email),
                  label: const Text('Email Magic Link')),

SizedBox(height: 40,),
                    OutlinedButton.icon(
                  onPressed: () {
                    goTo(const GoogleAuthPage());
                  },
                  icon: const Icon(Icons.g_mobiledata),
                  label: const Text('Google Auth')),

SizedBox(height: 40,),
                   OutlinedButton.icon(
                  onPressed: () {
                    goTo(const EmailPasswordAuthPage());
                  },
                  icon: const Icon(Icons.apple),
                  label: const Text('Apple Auth')),

                  SizedBox(height: 40,),
            ],
          ),
        )),
      ),
    );
  }

  void goTo(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
