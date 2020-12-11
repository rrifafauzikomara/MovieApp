import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(Sizes.dp10(context)),
      child: Shimmer.fromColors(
        baseColor: ColorPalettes.greyBg,
        highlightColor: ColorPalettes.white,
        child: Column(
          children: [
            Container(
              height: Sizes.width(context) / 2,
              width: Sizes.width(context),
              color: ColorPalettes.greyBg,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: Sizes.width(context) / 3,
                  height: Sizes.dp8(context),
                  margin: EdgeInsets.symmetric(
                    vertical: Sizes.dp10(context),
                    horizontal: 2.0,
                  ),
                  color: ColorPalettes.greyBg,
                ),
                Spacer(),
                Container(
                  height: Sizes.dp8(context),
                  width: Sizes.width(context) / 8,
                  color: ColorPalettes.greyBg,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
