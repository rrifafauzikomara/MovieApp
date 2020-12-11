import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: Sizes.dp16(context), vertical: Sizes.dp16(context)),
      child: Shimmer.fromColors(
        baseColor: ColorPalettes.greyBg,
        highlightColor: ColorPalettes.white,
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: EdgeInsets.only(bottom: Sizes.dp8(context)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // image
                Container(
                  width: Sizes.width(context) / 3,
                  height: Sizes.width(context) / 2,
                  color: ColorPalettes.greyBg,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(Sizes.dp10(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              // circle vote average
                              Container(
                                height: Sizes.width(context) / 10,
                                width: Sizes.width(context) / 10,
                                color: ColorPalettes.greyBg,
                              ),
                              SizedBox(
                                width: Sizes.dp10(context),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: Sizes.dp16(context),
                                      color: ColorPalettes.greyBg,
                                    ),
                                    SizedBox(
                                      height: Sizes.dp12(context),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: Sizes.dp12(context),
                                      color: ColorPalettes.greyBg,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Sizes.dp10(context),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              height: Sizes.dp30(context),
                              width: Sizes.width(context) / 7,
                              color: ColorPalettes.greyBg,
                            ),
                            SizedBox(
                              width: Sizes.dp10(context),
                            ),
                            Container(
                              height: Sizes.dp30(context),
                              width: Sizes.width(context) / 7,
                              color: ColorPalettes.white,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Sizes.dp10(context),
                        ),
                        Container(
                          width: double.infinity,
                          height: Sizes.dp12(context),
                          color: ColorPalettes.greyBg,
                        ),
                        SizedBox(
                          height: Sizes.dp10(context),
                        ),
                        Container(
                          width: double.infinity,
                          height: Sizes.dp12(context),
                          color: ColorPalettes.greyBg,
                        ),
                        SizedBox(
                          height: Sizes.dp10(context),
                        ),
                        Container(
                          width: double.infinity,
                          height: Sizes.dp12(context),
                          color: ColorPalettes.greyBg,
                        ),
                        SizedBox(
                          height: Sizes.dp10(context),
                        ),
                        Container(
                          width: double.infinity,
                          height: Sizes.dp12(context),
                          color: ColorPalettes.greyBg,
                        ),
                        SizedBox(
                          height: Sizes.dp10(context),
                        ),
                        Container(
                          width: double.infinity,
                          height: Sizes.dp12(context),
                          color: ColorPalettes.greyBg,
                        ),
                        SizedBox(
                          height: Sizes.dp10(context),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          itemCount: 6,
        ),
      ),
    );
  }
}
