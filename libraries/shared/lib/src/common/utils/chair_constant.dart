import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared/shared.dart';

class ChairConstant {
  static Widget grey(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.dp6(context)),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[800]),
        child: SvgPicture.asset(ImagesAssets.chairLight),
      ),
    );
  }

  static Widget red(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.dp6(context)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red[900],
        ),
        child: SvgPicture.asset(ImagesAssets.chairLight),
      ),
    );
  }

  static Widget white(BuildContext context, bool isWhite) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.dp6(context)),
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalettes.white,
          border: Border.all(
            color: isWhite ? ColorPalettes.grey : ColorPalettes.transparent,
          ),
        ),
        child: SvgPicture.asset(ImagesAssets.chairDark),
      ),
    );
  }

  static Widget orange(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.dp6(context)),
      child: Container(
        decoration: BoxDecoration(color: ColorPalettes.darkAccent),
        child: SvgPicture.asset(ImagesAssets.chairDark),
      ),
    );
  }
}
