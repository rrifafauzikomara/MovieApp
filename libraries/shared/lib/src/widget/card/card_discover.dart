import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CardDiscover extends StatelessWidget {
  final String image, title;
  final double rating;
  final List<int> genre;
  final Function onTap;

  const CardDiscover(
      {Key key, this.image, this.title, this.rating, this.genre, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dp20(context)),
          child: GestureDetector(
            onTap: onTap,
            child: CachedNetworkImage(
              imageUrl: image.imageOriginal,
              width: Sizes.width(context) / 2,
              placeholder: (context, url) => ShimmerDiscover(),
              errorWidget: (context, url, error) => ErrorImage(),
            ),
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
            children: genre.take(3).map(_buildGenreChip).toList(),
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

  Widget _buildGenreChip(int id) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(8),
      child: Text(
        Genres.genres[id],
        style: TextStyle(fontSize: 12, color: ColorPalettes.white),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: ColorPalettes.grey),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
