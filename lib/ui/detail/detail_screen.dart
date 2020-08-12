import 'dart:io';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail_movies';
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    var theme = Theme.of(context);
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: [
                CardMoviesHeader(
                  title: args.movies.title,
                  imageBanner: args.movies.backdropPath.imageOriginal,
                  imagePoster: args.movies.posterPath.imageOriginal,
                  rating: args.movies.voteAverage,
                  genre: args.movies.genreIds.take(3).map(buildGenreChip).toList(),
                ),
                Padding(
                    padding: EdgeInsets.all(Sizes.dp20(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Story line',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.dp16(context),
                          ),
                        ),
                        SizedBox(height: Sizes.dp8(context)),
                        Text(
                          args.movies.overview,
                        ),
                      ],
                    )),
                SizedBox(height: 50.0),
              ],
            ),
            Positioned(
              top: 40.0,
              right: Sizes.dp5(context),
              child: _buildFavoriteIcon(theme, args.movies),
            ),
            Positioned(
              top: 40,
              left: Sizes.dp5(context),
              child: IconButton(
                key: Key(KEY_TAP_BACK_BUTTON),
                icon: Platform.isAndroid
                    ? Icon(Icons.arrow_back)
                    : Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteIcon(ThemeData theme, Movies movies) {
    if (_isFavorite) {
      return IconButton(
        key: Key(KEY_TAP_ITEM_FAVORITE),
        iconSize: Sizes.dp30(context),
        color: theme.accentColor,
        icon: Icon(Icons.favorite),
        onPressed: () {
          setState(() => _isFavorite = false);
          PopUp.showSnackBar(
            Text(
              "Remove from Favorite",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Sizes.dp16(context),
                color: ColorPalettes.white,
              ),
            ),
            key: scaffoldKey,
          );
        },
      );
    } else {
      return IconButton(
        key: Key(KEY_TAP_ITEM_FAVORITE),
        iconSize: Sizes.dp30(context),
        color: theme.accentColor,
        icon: Icon(Icons.favorite_border),
        onPressed: () {
          setState(() => _isFavorite = true);
          PopUp.showSnackBar(
            Text(
              "Add to Favorite",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Sizes.dp16(context),
                color: ColorPalettes.white,
              ),
            ),
            key: scaffoldKey,
          );
        },
      );
    }
  }

}