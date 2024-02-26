import 'package:flutter/material.dart';

class AuthVars {
  static final loginformkey = GlobalKey<FormState>();
static final registerformkey = GlobalKey<FormState>();
  static String email = '';

  static String fullName = '';
  static String password = '';
  static String regX =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static clear() {
    email = "";
    password = "";
  }
}
