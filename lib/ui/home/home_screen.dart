import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';
  final String title;
  const HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Hello World',
        ),
      ),
    );
  }
}
