import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class RatingInformation extends StatelessWidget {
  final double rating;

  const RatingInformation({Key key, this.rating}) : super(key: key);

  Widget _buildRatingBar(ThemeData theme) {
    var stars = <Widget>[];

    for (var i = 1; i <= 5; i++) {
      var color = i <= rating ? theme.accentColor : Colors.black12;
      var star = Icon(
        Icons.star,
        color: color,
      );

      stars.add(star);
    }

    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var numericRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(rating.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: theme.accentColor,
              fontSize: Sizes.dp16(context),
            )),
        SizedBox(height: Sizes.dp4(context)),
        Text(
          'Ratings',
        ),
      ],
    );

    var starRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildRatingBar(theme),
        Padding(
          padding: EdgeInsets.only(
              top: Sizes.dp4(context), left: Sizes.dp4(context)),
          child: Text(
            'Grade now',
          ),
        ),
      ],
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        numericRating,
        SizedBox(width: Sizes.dp16(context)),
        starRating,
      ],
    );
  }
}
