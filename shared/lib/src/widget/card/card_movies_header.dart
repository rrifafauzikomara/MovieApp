import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CardMoviesHeader extends StatelessWidget {
  final bool isFromBanner;
  final int idMovie;
  final List<Widget> genre;
  final String title;
  final String imageBanner;
  final String imagePoster;
  final double rating;

  const CardMoviesHeader(
      {Key key,
      this.isFromBanner,
      this.idMovie,
      this.genre,
      this.title,
      this.imageBanner,
      this.imagePoster,
      this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: Sizes.dp20(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Sizes.dp8(context)),
        RatingInformation(
          rating: rating,
        ),
        SizedBox(height: Sizes.dp12(context)),
        Padding(
          padding: EdgeInsets.only(right: Sizes.dp8(context)),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: genre,
            ),
          ),
        ),
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: Sizes.width(context) / 3),
          child: ArcBannerImage(imageBanner),
        ),
        Positioned(
          bottom: 0.0,
          left: Sizes.dp16(context),
          right: Sizes.dp16(context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Hero(
                tag: isFromBanner ? idMovie : imagePoster,
                child: Poster(
                  imagePoster,
                  Sizes.width(context) / 2,
                ),
              ),
              SizedBox(width: Sizes.dp16(context)),
              Expanded(child: movieInformation),
            ],
          ),
        ),
      ],
    );
  }
}
