import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class BannerHome extends StatefulWidget {
  final Function(int index, CarouselPageChangedReason reason) onPageChanged;
  final Result data;
  final int currentIndex;
  final String routeNameDetail, routeNameAll;

  const BannerHome(
      {Key key,
      this.onPageChanged,
      this.data,
      this.currentIndex,
      this.routeNameDetail,
      this.routeNameAll})
      : super(key: key);

  @override
  _BannerHomeState createState() => _BannerHomeState();
}

class _BannerHomeState extends State<BannerHome> {
  @override
  Widget build(BuildContext context) {
    var data =
        widget.data.results.length > 10 ? 10 : widget.data.results.length;
    return Column(
      children: <Widget>[
        // Banner
        Container(
          height: Sizes.width(context) / 2,
          child: CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
              viewportFraction: 1.0,
              aspectRatio: 2.0,
              onPageChanged: widget.onPageChanged,
            ),
            items: <Widget>[
              for (var i = 0; i < data; i++)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigation.intentWithData(
                        context,
                        widget.routeNameDetail,
                        ScreenArguments(widget.data.results[i]),
                      );
                    },
                    child: GridTile(
                      child: CachedNetworkImage(
                        imageUrl: widget.data.results[i].backdropPath.imageOriginal,
                        width: Sizes.width(context),
                        fit: BoxFit.fill,
                        placeholder: (context, url) => LoadingIndicator(),
                        errorWidget: (context, url, error) => ErrorImage(),
                      ),
                      footer: Container(
                        color: ColorPalettes.whiteSemiTransparent,
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          widget.data.results[i].title,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: ColorPalettes.darkBG,
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.dp16(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        _dotIndicator(data),
      ],
    );
  }

  Widget _dotIndicator(int data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (var i = 0; i < data; i++)
          Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 2.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.currentIndex == i
                  ? ColorPalettes.darkAccent
                  : ColorPalettes.grey,
            ),
          ),
        Spacer(),
        GestureDetector(
          onTap: () {
            Navigation.intent(context, widget.routeNameAll);
          },
          child: Text(
            'See all',
            style: TextStyle(
              fontSize: Sizes.dp14(context),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
