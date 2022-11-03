import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthPage extends StatefulWidget {
  const GoogleAuthPage({super.key});

  @override
  State<GoogleAuthPage> createState() => _GoogleAuthPageState();
}

class _GoogleAuthPageState extends State<GoogleAuthPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
  ]);

  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });
    //sign in silently if already signed in
    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            SizedBox(height: 190,),
            ElevatedButton.icon(
                onPressed: () {
                  try {
                    Future<GoogleSignInAccount?> account =
                        _googleSignIn.signIn();
                    account.then((value) => print(value?.email));
                  } catch (e) {
                    print(e);
                  }
                },
                icon: Icon(Icons.g_mobiledata),
                label: Text('Sign In W Google'))
          ],
        )),
      ),
    );
  }
}
