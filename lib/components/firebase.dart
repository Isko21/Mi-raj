import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogIn() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googlAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googlAuth.accessToken, idToken: googlAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future logOut() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

class AnonymousSignInProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future signIn() async {
    try {
      final result = await auth.signInAnonymously();
      User user = result.user!;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  notifyListeners();
}
