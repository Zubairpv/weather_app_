import 'package:flutter/material.dart';

const primarycolor = Colors.white;
const textinputdecoration = InputDecoration(
  
    labelStyle: TextStyle(color: primarycolor, fontWeight: FontWeight.w300),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primarycolor, width: 2)),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primarycolor, width: 2)),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primarycolor, width: 2)));
