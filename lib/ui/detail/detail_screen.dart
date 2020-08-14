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
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    context.bloc<TrailerBloc>().add(LoadTrailer(args.movies.id));
    context.bloc<CrewBloc>().add(LoadCrew(args.movies.id));
    var theme = Theme.of(context);
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Stack(
          children: <Widget>[
            Column(
              children: [
                CardMoviesHeader(
                  title: args.movies.title == null
                      ? args.movies.tvName
                      : args.movies.title,
                  imageBanner: args.movies.backdropPath.imageOriginal,
                  imagePoster: args.movies.posterPath.imageOriginal,
                  rating: args.movies.voteAverage,
                  genre:
                      args.movies.genreIds.take(3).map(buildGenreChip).toList(),
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Sizes.dp20(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trailer',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.dp16(context),
                        ),
                      ),
                      SizedBox(height: Sizes.dp8(context)),
                      _buildTrailer(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Sizes.dp20(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Crew',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.dp16(context),
                        ),
                      ),
                      SizedBox(height: Sizes.dp8(context)),
                      _buildCrew(),
                    ],
                  ),
                ),
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

  Widget _buildTrailer() {
    return Container();
    BlocBuilder<TrailerBloc, TrailerState>(
      builder: (context, state) {
        if (state is TrailerHasData) {
          return Text(state.trailer.trailer[0].title);
        } else if (state is TrailerLoading) {
          return ShimmerBanner();
        } else if (state is TrailerError) {
          return ErrorHandlerWidget(
              errorMessage: state.errorMessage);
        } else if (state is TrailerNoData) {
          return NoDataWidget(message: AppConstant.noData);
        } else if (state is TrailerNoInternetConnection) {
          return NoInternetConnectionWidget(
            message: AppConstant.noInternetConnection,
            onPressed: () {
              context
                  .bloc<MovieNowPlayingBloc>()
                  .add(LoadMovieNowPlaying());
            },
          );
        } else {
          return Center(child: Text(""));
        }
      },
    );
  }

  Widget _buildCrew() {
    return Container(
      width: Sizes.width(context),
      height: Sizes.width(context) / 3,
      child: BlocBuilder<CrewBloc, CrewState>(
        builder: (context, state) {
          if (state is CrewHasData) {
            return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              key: Key(KEY_LIST_VIEW_UP_COMING),
              itemCount: state.crew.crew.length,
              itemBuilder: (BuildContext context, int index) {
                Crew crew = state.crew.crew[index];
                return CardCrew(
                  image: crew.profile,
                  name: crew.characterName,
                );
              },
            );
          } else if (state is CrewLoading) {
            return ShimmerCard();
          } else if (state is CrewError) {
            return ErrorHandlerWidget(
                errorMessage: state.errorMessage);
          } else if (state is CrewNoData) {
            return NoDataWidget(message: AppConstant.noData);
          } else if (state is CrewNoInternetConnection) {
            return NoInternetConnectionWidget(
              message: AppConstant.noInternetConnection,
              onPressed: () {
                context
                    .bloc<MovieNowPlayingBloc>()
                    .add(LoadMovieNowPlaying());
              },
            );
          } else {
            return Center(child: Text(""));
          }
        },
      ),
    );
  }
}
