import 'dart:io';
import 'package:shared/shared.dart';
import 'package:flutter/material.dart';

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

class DetailMovies extends StatelessWidget {
  static const routeName = '/detail_movies';

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
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
                  )
                ),
                SizedBox(height: 50.0),
              ],
            ),
            Positioned(
              top: Sizes.dp30(context),
              left: Sizes.dp5(context),
              child: IconButton(
                icon: Platform.isAndroid? Icon(Icons.arrow_back) : Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
