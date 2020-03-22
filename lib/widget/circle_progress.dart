import 'package:flutter/material.dart';
import 'package:moviecatalogue/common/color_palettes.dart';
import 'package:moviecatalogue/common/sizes.dart';

class CircleProgress extends StatelessWidget {
  final String vote;

  const CircleProgress({Key key, this.vote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(
                  Sizes.dp20(context),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  ColorPalettes.getColorCircleProgress(
                    double.parse(vote),
                  ),
                ),
                backgroundColor: Colors.grey,
                value: double.parse(vote) / 10.0,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 30,
              height: 30,
              child: Center(
                child: Text(
                  (double.parse(vote) * 10.0).floor().toString() + '%',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Sizes.dp10(context),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
