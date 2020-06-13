import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class ErrorHandlerWidget extends StatelessWidget {
  final String errorMessage;

  const ErrorHandlerWidget({Key key, @required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            ImagesAssets.error,
            height: Sizes.width(context) / 2,
            width: Sizes.width(context) / 2,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: Sizes.dp30(context),
          ),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Sizes.dp16(context),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
