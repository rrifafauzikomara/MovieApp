import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CardDiscover extends StatelessWidget {
  final String image, title;
  final double rating;
  final List<Widget> genre;

  const CardDiscover({Key key, this.image, this.title, this.rating, this.genre})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            imageUrl: image.imageOriginal,
            width: Sizes.width(context) / 2,
            placeholder: (context, url) => LoadingIndicator(),
            errorWidget: (context, url, error) => ErrorImage(),
          ),
        ),
        SizedBox(
          height: Sizes.height(context) * .02,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: Sizes.width(context) / 14,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: Sizes.height(context) * .01,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: genre,
          ),
        ),
        SizedBox(
          height: Sizes.height(context) * .01,
        ),
        Text(
          rating.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: Sizes.width(context) / 16,
          ),
        ),
        SizedBox(
          height: Sizes.height(context) * .005,
        ),
        buildRatingBar(theme, context, rating),
      ],
    );
  }
}
