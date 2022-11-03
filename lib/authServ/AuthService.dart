import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_app/common.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future createAccountwEmailandPass(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        showSnackx(context, 'Success');
      });
      //  _auth.currentUser!.updateDisplayName(name);

    } on FirebaseAuthException catch (e) {
      showSnackx(context, e.code);
    }
  }

  Future signinwEmailandPass(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        showSnackx(context, 'Success');
      });
    } on FirebaseAuthException catch (e) {
      showSnackx(context, e.code);
    }
  }

  Future resetPasswordwEmailLink(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email).then((value) {
        showSnackx(context, 'Success');
      });
    } on FirebaseAuthException catch (e) {
      showSnackx(context, e.code);
    }
  }

  late String _verificationID;
  Future verifyPhoneNum(BuildContext context, String phoneNum) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNum,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (phoneAuthCredential) async {
          print('auto verif completed');
          // print(phoneAuthCredential.smsCode);
          showSnackx(context, phoneAuthCredential.toString());
          UserCredential user =
              await _auth.signInWithCredential(phoneAuthCredential);
          print(user);
        },
        verificationFailed: ((error) {
          showSnackx(context, 'VERIF FAILED $error');
        }),
        codeSent: (verificationId, forceResendingToken) {
          showSnackx(context, 'CODE SENT');
          _verificationID = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          showSnackx(context, 'codeAutoRetrievalTimeout');
          _verificationID = verificationId;
        },
      );
    } on FirebaseAuthException catch (e) {
      showSnackx(context, e.code);
    }
  }

  Future verifyCodeSentToPhone(String smscode) async {
    UserCredential user = await _auth.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: _verificationID, smsCode: smscode),
    );

    print(user);
  }

  var acodeSettin = ActionCodeSettings(
    // URL you want to redirect back to. The domain (www.example.com) for this
    // URL must be whitelisted in the Firebase Console.
    url: 'https://saymynameinj.page.link',

    handleCodeInApp: true,
    iOSBundleId: 'com.example.flutterAuthApp',
    androidPackageName: 'com.example.flutter_auth_app',

    androidInstallApp: true,
    androidMinimumVersion: '12',
    dynamicLinkDomain: 'saymynameinj.page.link',
  );

  Future sendMagicLink(BuildContext context, String email) async {
    print('Magic Link');
    try {
      await _auth.sendSignInLinkToEmail(
          email: email, actionCodeSettings: acodeSettin);
      print('email sent');
      showSnackx(context, 'Email sent');
    } catch (e) {
      print(e);
      showSnackx(context, e.toString());
    }
  }

  Future signInwMagicLink(String incomingLink, String email) async {
    // Confirm the link is a sign-in with email link.
    if (_auth.isSignInWithEmailLink(incomingLink)) {
      try {
        // The client SDK will parse the code from the link for you.
        final userCredential = await _auth.signInWithEmailLink(email: email, emailLink: incomingLink);

        // You can access the new user via userCredential.user.
        
        print(userCredential.user?.email);

        print('Successfully signed in with email link!');
      } catch (error) {
        print(error.toString());
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
