import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  @override
  notifyListeners();
}

class AppleIdsignInProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Future signIn() async{
  //   try{
  //     final result = await auth.signInWithApp
  //   }
  // }
}
