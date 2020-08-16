import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const CustomButton({Key key, @required this.onPressed, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.width(context) * .9,
      height: Sizes.height(context) * .08,
      margin: EdgeInsets.only(bottom: Sizes.dp20(context)),
      child: FlatButton(
        color: ColorPalettes.darkAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Sizes.dp10(context),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: ColorPalettes.white,
            fontWeight: FontWeight.bold,
            fontSize: Sizes.dp18(context),
          ),
        ),
      ),
    );
  }
}
