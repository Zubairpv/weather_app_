import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_machine/presentation/pages/login_page_vars.dart';

abstract class AuthService {
  Future loginuser();
  Future registeruser();
  Future logoutUser();
}

class AuthServiceImpl implements AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future loginuser() async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: AuthVars.email, password: AuthVars.password))
          .user;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (f) {
      debugPrint(f.toString());
      return f.message;
    }
  }

  @override
  Future registeruser() async {
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: AuthVars.email, password: AuthVars.password))
          .user!;

      // Send verification email
      await user.sendEmailVerification();

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  @override
  Future logoutUser() async {
    firebaseAuth.signOut();
  }
}
