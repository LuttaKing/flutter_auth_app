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

  late String verificationID;
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
          print('verif failed: $error');
          showSnackx(context, error.toString());
        }),
        codeSent: (verificationId, forceResendingToken) {
          print('CODE SENT');
          showSnackx(context, 'CODE SENT');
          verificationID = verificationId;
          print('Verif ID: $verificationID');
        },
        codeAutoRetrievalTimeout: (verificationId) {
          print('codeAutoRetrievalTimeout');
          showSnackx(context, 'codeAutoRetrievalTimeout');
          verificationID = verificationId;
        },
      );
    } on FirebaseAuthException catch (e) {
      showSnackx(context, e.code);
    }
  }

  Future verifyCodeSentToPhone(String smscode) async {
    print('Verif ID found is $verificationID');
    UserCredential user = await _auth.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: smscode),
    );

    print(user);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
