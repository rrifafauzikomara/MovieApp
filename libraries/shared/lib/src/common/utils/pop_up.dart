import 'package:flutter/material.dart';

class PopUp {
  static void showSnackBarSuccess(String message, BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ));
  }

  static void showSnackBarError(String error, BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Colors.red,
    ));
  }
}
