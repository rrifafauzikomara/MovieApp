import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDiscover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorPalettes.greyBg,
      highlightColor: ColorPalettes.white,
      child: Container(
        height: Sizes.width(context) / 1.4,
        width: Sizes.width(context) / 2,
        decoration: BoxDecoration(
          color: ColorPalettes.greyBg,
          borderRadius: BorderRadius.all(
            Radius.circular(
              Sizes.dp10(context),
            ),
          ),
        ),
      ),
    );
  }
}
