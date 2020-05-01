import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class ScreenArguments {
  final List<Widget> genre;
  final String title;
  final String imageBanner;
  final String imagePoster;
  final double rating;
  final String overview;

  ScreenArguments(this.genre, this.title, this.imageBanner, this.imagePoster,
      this.rating, this.overview);
}

class DetailMovies extends StatefulWidget {
  static const routeName = '/detail_movies';
  @override
  _DetailMoviesState createState() => _DetailMoviesState();
}

class _DetailMoviesState extends State<DetailMovies> {
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

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
                  title: args.title,
                  imageBanner:
                  'https://image.tmdb.org/t/p/original${args.imageBanner}',
                  imagePoster:
                  'https://image.tmdb.org/t/p/w185${args.imagePoster}',
                  rating: args.rating,
                  genre: args.genre,
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
                          args.overview,
                        ),
                      ],
                    )),
                SizedBox(height: 50.0),
              ],
            ),
            Positioned(
              top: 40.0,
              right: Sizes.dp5(context),
              child: IconButton(
                iconSize: Sizes.dp30(context),
                color: theme.accentColor,
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  PopUp.showSnackBar(
                    Text(
                      "Favorite",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Sizes.dp16(context),
                        color: ColorPalettes.white,
                      ),
                    ),
                    key: scaffoldKey,
                  );
                },
              ),
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
}