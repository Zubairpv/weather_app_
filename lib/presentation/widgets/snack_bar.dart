import 'package:flutter/material.dart';

class BasicWidgets {
  static SnackBar showsnackbar(context, color, messsage) {
    return SnackBar(
      content: Text(
        messsage,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () {},
        textColor: Colors.white,
      ),
    );
  }
}
