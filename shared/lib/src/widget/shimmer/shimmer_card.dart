import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorPalettes.greyBg,
      highlightColor: ColorPalettes.white,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Sizes.width(context) / 1.8,
              width: Sizes.width(context) / 2.5,
              decoration: BoxDecoration(
                color: ColorPalettes.greyBg,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Sizes.dp10(context),
                  ),
                ),
              ),
            ),
            SizedBox(width: Sizes.dp10(context)),
            Container(
              height: Sizes.width(context) / 1.8,
              width: Sizes.width(context) / 2.5,
              decoration: BoxDecoration(
                color: ColorPalettes.greyBg,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Sizes.dp10(context),
                  ),
                ),
              ),
            ),
            SizedBox(width: Sizes.dp10(context)),
            Container(
              height: Sizes.width(context) / 1.8,
              width: Sizes.width(context) / 2.5,
              decoration: BoxDecoration(
                color: ColorPalettes.greyBg,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Sizes.dp10(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
