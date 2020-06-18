import 'package:flutter/material.dart';

class Navigation {

  static back(BuildContext context) {
    Navigator.pop(context);
  }

  static intent(BuildContext context, String nameRouted) {
    Navigator.pushNamed(context, nameRouted);
  }

  static intentWithData(BuildContext context, String nameRouted, Object argumentClass) {
    Navigator.pushNamed(
        context,
        nameRouted,
        arguments: argumentClass
    );
  }

}