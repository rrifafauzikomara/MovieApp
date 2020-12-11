import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Navigation {

  static back(BuildContext context) {
    Navigator.pop(context);
  }

  static intent(BuildContext context, String nameRouted) {
    Navigator.pushNamed(context, nameRouted);
  }

  static intentWithoutBack(BuildContext context, String nameRouted) {
    Navigator.pushReplacementNamed(context, nameRouted);
  }

  static intentWithClearAllRoutes(BuildContext context, String nameRouted) {
    Navigator.of(context).pushNamedAndRemoveUntil(nameRouted, (Route<dynamic> route) => false);
  }

  static intentWithData(BuildContext context, String nameRouted, Object argumentClass) {
    Navigator.pushNamed(
        context,
        nameRouted,
        arguments: argumentClass
    );
  }

  // URL valid for this plugin only are
  // https://www.flutter.dev
  // http://www.flutter.dev
  // https://flutter.dev
  // http://flutter.dev
  //
  // For this it's not working
  // www.flutter.dev
  // flutter.dev
  static launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}