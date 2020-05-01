import 'dart:io';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class ScreenArguments {
  final Movies movies;
  ScreenArguments(this.movies);
}

class DetailMovies extends StatefulWidget {
  static const routeName = '/detail_movies';
  @override
  _DetailMoviesState createState() => _DetailMoviesState();
}

class _DetailMoviesState extends State<DetailMovies> {

  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  SessionManager _sessionManager = SessionManager();
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    var theme = Theme.of(context);
    _sessionManager.getFavorite().then((value) {
      if(value == args.movies.id) {
        setState(() => _isFavorite = value != null);
      }
    });

    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: [
                CardMoviesHeader(
                  title: args.movies.title,
                  imageBanner:
                  'https://image.tmdb.org/t/p/original${args.movies.backdrop_path}',
                  imagePoster:
                  'https://image.tmdb.org/t/p/w185${args.movies.poster_path}',
                  rating: args.movies.vote_average,
                  genre: args.movies.genre_ids.take(3).map(buildGenreChip).toList(),
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
        iconSize: Sizes.dp30(context),
        color: theme.accentColor,
        icon: Icon(Icons.favorite),
        onPressed: () {
          _sessionManager.deleteFromFavorite();
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
        iconSize: Sizes.dp30(context),
        color: theme.accentColor,
        icon: Icon(Icons.favorite_border),
        onPressed: () {
          _sessionManager.saveToFavorite(movies.id);
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