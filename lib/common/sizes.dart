import 'package:flutter/material.dart';

class Sizes {

  static height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static dp4(BuildContext context) {
    return MediaQuery.of(context).size.width / 100;
  }

  static dp6(BuildContext context) {
    return MediaQuery.of(context).size.width / 70;
  }

  static dp8(BuildContext context) {
    return MediaQuery.of(context).size.width / 54;
  }

  static dp10(BuildContext context) {
    return MediaQuery.of(context).size.width / 41;
  }

  static dp12(BuildContext context) {
    return MediaQuery.of(context).size.width / 34;
  }

  static dp14(BuildContext context) {
    return MediaQuery.of(context).size.width / 29;
  }

  static dp16(BuildContext context) {
    return MediaQuery.of(context).size.width / 26;
  }

  static dp18(BuildContext context) {
    return MediaQuery.of(context).size.width / 23;
  }

  static dp20(BuildContext context) {
    return MediaQuery.of(context).size.width / 20;
  }

  static dp22(BuildContext context) {
    return MediaQuery.of(context).size.width / 17;
  }

  static dp24(BuildContext context) {
    return MediaQuery.of(context).size.width / 16;
  }

  static dp25(BuildContext context) {
    return MediaQuery.of(context).size.width / 15;
  }

}