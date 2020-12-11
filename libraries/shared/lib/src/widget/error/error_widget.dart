import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;

  const CustomErrorWidget({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Sizes.dp12(context),
        ),
      ),
    );
  }
}
